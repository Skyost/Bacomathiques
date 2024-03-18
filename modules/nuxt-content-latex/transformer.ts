// noinspection ES6PreferShortImport

import path from 'path'
import fs from 'fs'
// @ts-ignore
import { defineTransformer } from '@nuxt/content/transformers'
import { HTMLElement } from 'node-html-parser'
import GithubSlugger from 'github-slugger'
import * as latex from 'that-latex-lib'
import { consola } from 'consola'
import { normalizeString, replaceLineBreaks } from '../../utils/utils'
import { siteContentSettings } from '../../site/content'
import type { Toc, TocEntry } from '../../types'
import { debug } from '../../site/debug'
import { moduleName } from './common'

/**
 * The logger instance.
 */
const logger = consola.withTag(moduleName)

/**
 * Nuxt content transformer for .tex files.
 */
export default defineTransformer({
  name: 'latex',
  extensions: ['.tex'],
  // @ts-ignore
  parse (_id: string, rawContent: string) {
    // Absolute path to the source directory.
    const sourceDirectoryPath = path.resolve('./')

    // Absolute path to the content directory.
    const contentDirectoryPath = path.resolve(sourceDirectoryPath, 'content')

    // Absolute path to the .tex file.
    const filePath = path.resolve(sourceDirectoryPath, _id.replaceAll(':', '/'))
    logger.info(`Processing ${filePath}...`)

    // Extract images from the .tex file content and return the modified content.
    const moduleDataDirectoryPath = path.resolve(sourceDirectoryPath, 'node_modules', `.${moduleName}`)
    const assetsRootDirectoryPath = path.resolve(moduleDataDirectoryPath, siteContentSettings.latexAssetsDestinationDirectory)

    // Load the Pandoc redefinitions header content.
    const pandocHeader = fs.readFileSync(path.resolve(contentDirectoryPath, siteContentSettings.dataLatexDirectory, siteContentSettings.pandocRedefinitions), { encoding: 'utf8' })

    // Parse the Pandoc HTML output.
    const getResolvedImageCacheDirectoryPath = (resolvedImageTexFilePath: string) => path.resolve(sourceDirectoryPath, siteContentSettings.previousBuildDownloadDirectory, path.dirname(path.relative(moduleDataDirectoryPath, resolvedImageTexFilePath)))
    const { replacedImages, htmlResult: root } = latex.transformToHtml(
      filePath,
      {
        pandocHeader,
        pandocArguments: ['--shift-heading-level-by=1'],
        getIncludeGraphicsDirectories: siteContentSettings.getIncludeGraphicsDirectories,
        assetsRootDirectoryPath,
        getExtractedImageTargetDirectory: (_extractedFrom, _assetName) => path.dirname(assetsRootDirectoryPath),
        getResolvedImageCacheDirectoryPath,
        renderMathElement,
        generateIfExists: !debug
      },
      true,
      rawContent
    )

    // Handles dark images.
    handleDarkImages(root, replacedImages, assetsRootDirectoryPath, getResolvedImageCacheDirectoryPath)

    // Remove empty titles from the HTML content and add identifiers.
    handleTitles(root)

    // Replace vspace elements in the HTML content.
    replaceVspaceElements(root)

    // Adjust columns size in the HTML content.
    addDataAttributes(root)

    // We save the body and process the summary.
    const header = getHeader(root)
    const body = root.outerHTML
    removeElementsForSummary(root)
    const summary = root.outerHTML

    logger.success(`Successfully processed ${filePath} !`)

    // Return the parsed content object.
    return {
      _id,
      body,
      summary,
      ...header
    }
  }
})

/**
 * Remove empty titles (h2, h3, h4) from the HTML root element and add identifiers.
 *
 * @param {HTMLElement} root - The root HTML element.
 */
const handleTitles = (root: HTMLElement) => {
  const slugger = new GithubSlugger()
  const titles = root.querySelectorAll('h2, h3, h4')
  for (const title of titles) {
    // Check if the text content of the title is empty and remove it.
    if (title.text.trim().length === 0) {
      title.remove()
      continue
    }
    if (title.tagName === 'H2' || title.tagName === 'H3') {
      title.setAttribute('id', normalizeString(slugger.slug(title.text, false)))
    }
  }
}

/**
 * Replace vertical space elements with corresponding styles.
 *
 * @param {HTMLElement} root - The root HTML element.
 */
const replaceVspaceElements = (root: HTMLElement) => {
  const vspaces = root.querySelectorAll('.vertical-space')
  for (const vspace of vspaces) {
    // Get the trimmed text content.
    const text = vspace.text.trim()

    // Check if the text starts with '-' and remove the element.
    if (text.startsWith('-')) {
      vspace.remove()
      continue
    }

    // Set the 'style' attribute to control the height.
    vspace.setAttribute('style', `height: ${text};`)
    vspace.innerHTML = ''
  }
}

/**
 * Adds `data-src-dark`, if possible, to resolved tex images.
 * @param root The parsed root element.
 * @param replacedImages The replaced images.
 * @param assetsRootDirectoryPath The assets root directory path.
 * @param getResolvedImageCacheDirectoryPath Returns the resolved image cache directory path for a given image path.
 */
const handleDarkImages = (
  root: HTMLElement,
  replacedImages: {[key: string]: string},
  assetsRootDirectoryPath: string,
  getResolvedImageCacheDirectoryPath: (filePath: string) => string
) => {
  const images = root.querySelectorAll('img')
  for (const image of images) {
    const src = image.getAttribute('src')
    if (!src) {
      continue
    }
    let imagePath = replacedImages[src]
    const parts = path.parse(imagePath)
    const darkImagePath = path.resolve(parts.dir, parts.name + '-dark' + parts.ext)
    if (!fs.existsSync(darkImagePath) || parts.ext !== '.tex') {
      continue
    }
    // Generate an SVG from the PDF.
    const { builtFilePath } = latex.generateSvg(
      imagePath,
      {
        includeGraphicsDirectories: siteContentSettings.getIncludeGraphicsDirectories(darkImagePath),
        cacheDirectoryPath: getResolvedImageCacheDirectoryPath?.call(this, darkImagePath),
        optimize: true,
        generateIfExists: !debug
      }
    )

    // If the PDF couldn't be converted to SVG, return null.
    if (!builtFilePath) {
      return null
    }

    // Update the image path to the generated SVG.
    imagePath = builtFilePath
    image.setAttribute('data-src-dark', '/' + path.relative(path.dirname(assetsRootDirectoryPath), imagePath).replace(/\\/g, '/'))
  }
}

/**
 * Add some data attributes to the HTML content.
 *
 * @param {HTMLElement} root - The root HTML element.
 */
const addDataAttributes = (root: HTMLElement) => {
  const variants = ['formula', 'proof', 'tip', 'exercise', 'correction']
  for (const variant of variants) {
    let variantCount = 1
    const bubbles = root.querySelectorAll(`.bubble-${variant}`)
    for (const bubble of bubbles) {
      const headings = bubble.querySelectorAll('h4')
      for (const heading of headings) {
        if (heading.textContent === '') {
          heading.remove()
        }
      }
      const contentWidth = bubble.querySelector('.content-width')
      let contentWidthAttribute = ''
      if (contentWidth) {
        contentWidthAttribute = ` data-content-width="${contentWidth.textContent.trim()}"`
        contentWidth.remove()
      }
      bubble.replaceWith(`<div id="${variant}-${variantCount}" class="bubble" data-variant="${variant}"${contentWidthAttribute}>${bubble.innerHTML}</div>`)
      variantCount++
    }
  }
  const representations = root.querySelectorAll('.geogebra-representation')
  for (const representation of representations) {
    const id = representation.rawText.trim()
    representation.replaceWith(`<div class="representation" data-geogebra-id="${id}"></div>`)
  }
}

/**
 * Renders a given math element.
 * @param {HTMLElement} element The element.
 * @returns {string} The result.
 */
const renderMathElement = (element: HTMLElement): string => {
  // Determine if it's a display math environment.
  const displayMode = element.getAttribute('env') === 'displaymath'
  // Replace the math element with the rendered KaTeX HTML.
  const renderedMath = latex.renderMathElement(element, {
    '\\parallelslant': '\\mathbin{\\!/\\mkern-5mu/\\!}',
    '\\ensuremath': '#1'
  })
  return `<span class="math-rendered" data-latex="${replaceLineBreaks(element.text.trim())}" data-latex-display="${displayMode}">${renderedMath}</span>`
}

/**
 * Extract header information from the HTML structure of a LaTeX document.
 *
 * @param {HTMLElement} root - The root HTML element of the document.
 * @returns {{ [key: string]: any }} Header information.
 */
const getHeader = (root: HTMLElement): { [key: string]: any } => {
  // Initialize the header object with the slug.
  const yamlHeader : { [key: string]: any } = {}

  // Adds defined headers.
  const headers = root.querySelectorAll('.document-header')
  for (const header of headers) {
    const content = header.querySelector('p')
    if (content && content.innerHTML.trim().length > 0) {
      const h2 = header.querySelector('h2')
      if (h2) {
        const id = h2.innerHTML
        const value = replaceLineBreaks(content.innerHTML.trim())
        yamlHeader[id] = /^[0-9]+$/.test(value) ? parseInt(value) : value
      }
    }
    header.remove()
  }

  // Initializes title-search, PDF and preview links.
  if (yamlHeader.level) {
    if (yamlHeader.title) {
      yamlHeader['title-search'] = normalizeString(`${yamlHeader.title} (${yamlHeader.level})`)
    }

    if (yamlHeader.id) {
      yamlHeader.pdf = `/pdf/${yamlHeader.level}/${yamlHeader.id}.pdf`
      yamlHeader.preview = `/img/lessons/${yamlHeader.level}/${yamlHeader.id}/preview.jpg`
    }
  }

  // Sets whether this lesson is a specialty.
  if (yamlHeader.specialty) {
    yamlHeader.specialty = true
  }

  // Get and parse the table of contents.
  yamlHeader.toc = generateToc(root)
  return yamlHeader
}

/**
 * Parses an HTML DOM tree and generates a table of contents.
 * @param {HTMLElement} root - The root HTML element of the document.
 * @returns {Toc} - The generated table of contents.
 */
function generateToc (root: HTMLElement): Toc {
  const toc: Toc = []
  const findEntryParent = (toFind: TocEntry, entries: TocEntry[] = toc) => {
    for (const entry of entries) {
      if (entry.children.includes(toFind)) {
        return entry
      }
      findEntryParent(toFind, entry.children)
    }
    return null
  }

  let currentDepth = 0
  let preTocEntry: TocEntry | null = null

  const headings = root.querySelectorAll('h1, h2, h3')
  for (const heading of headings) {
    const depth = parseInt(heading.outerHTML.match(/<h([\d]).*>/)![1])
    const entry: TocEntry = {
      id: heading.id,
      text: heading.text,
      depth,
      children: []
    }
    switch (depth >= currentDepth) {
      case true:
        if (!preTocEntry) {
          preTocEntry = entry
          toc.push(preTocEntry!)
        } else {
          const parent = entry.depth > preTocEntry.depth ? preTocEntry : findEntryParent(preTocEntry)
          parent?.children.push(entry)
          preTocEntry = entry
        }
        break
      case false:
        while (true) {
          if (preTocEntry!.depth < entry.depth) {
            preTocEntry!.children.push(entry)
            preTocEntry = entry
            break
          }
          preTocEntry = findEntryParent(preTocEntry!)
          if (!preTocEntry) {
            toc.push(entry)
            preTocEntry = entry
            break
          }
        }
        break
    }
    currentDepth = depth
    preTocEntry.id = heading.id
  }

  return toc
}

/**
 * Removes elements that should not be included inside the summary.
 * @param {HTMLElement} root - The root HTML element of the document.
 */
function removeElementsForSummary (root: HTMLElement) {
  const elements = root.querySelectorAll('.bubble[data-variant="tip"], .bubble[data-variant="proof"], .nosummary')
  for (const element of elements) {
    element.remove()
  }
}
