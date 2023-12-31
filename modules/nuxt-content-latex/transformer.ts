// noinspection ES6PreferShortImport

import { spawnSync } from 'child_process'
import path from 'path'
import fs from 'fs'
// @ts-ignore
import { defineTransformer } from '@nuxt/content/transformers'
import { HTMLElement, parse } from 'node-html-parser'
import katex from 'katex'
import GithubSlugger from 'github-slugger'
import { createResolver, type Resolver } from '@nuxt/kit'
import { getFileName, normalizeString, replaceLineBreaks } from '../../utils/utils'
import * as latex from '../../utils/latex'
import * as logger from '../../utils/logger'
import { siteContentSettings } from '../../site/content'
import type { Toc, TocEntry } from '../../types'
import { name } from './index'

/**
 * Nuxt content transformer for .tex files.
 */
export default defineTransformer({
  name: 'latex',
  extensions: ['.tex'],
  // @ts-ignore
  parse (_id: string, content: string) {
    // Resolver for creating absolute paths.
    const resolver = createResolver(import.meta.url)

    // Absolute path to the source directory.
    const sourceDirectoryPath = path.resolve('./')

    // Absolute path to the content directory.
    const contentDirectoryPath = resolver.resolve(sourceDirectoryPath, 'content')

    // Absolute path to the .tex file.
    const filePath = resolver.resolve(sourceDirectoryPath, _id.replaceAll(':', '/'))
    logger.info(name, `Processing ${filePath}...`)

    // Extract images from the .tex file content and return the modified content.
    const moduleDataDirectoryPath = resolver.resolve(sourceDirectoryPath, 'node_modules', `.${name}`)
    const assetsDirectoryPath = resolver.resolve(moduleDataDirectoryPath, siteContentSettings.latexAssetsDestinationDirectory)

    // Load the Pandoc redefinitions header content.
    const pandocHeader = fs.readFileSync(resolver.resolve(contentDirectoryPath, siteContentSettings.dataLatexDirectory, siteContentSettings.pandocRedefinitions), { encoding: 'utf8' })

    // Run Pandoc to convert the .tex content to HTML.
    const pandocResult = spawnSync(
      'pandoc',
      [
        '-f',
        'latex-auto_identifiers',
        '-t',
        'html',
        '--shift-heading-level-by=1',
        '--gladtex',
        '--html-q-tags'
      ],
      {
        env: process.env,
        cwd: path.resolve(path.dirname(filePath)),
        encoding: 'utf8',
        input: pandocHeader + content
      }
    )

    // Throw an error if the Pandoc transformation fails.
    if (pandocResult.status !== 0) {
      throw pandocResult.stderr
    }

    // Parse the Pandoc HTML output.
    const root = parse(pandocResult.stdout)

    // Replace images in the HTML content.
    replaceImages(
      resolver,
      root,
      filePath,
      moduleDataDirectoryPath,
      assetsDirectoryPath,
      sourceDirectoryPath,
      contentDirectoryPath
    )

    // Remove empty titles from the HTML content and add identifiers.
    handleTitles(root)

    // Replace vspace elements in the HTML content.
    replaceVspaceElements(root)

    // Adjust columns size in the HTML content.
    addDataAttributes(root)

    // Render math elements in the HTML content.
    renderMath(root)

    // We save the body and process the summary.
    const header = getHeader(root)
    const body = root.outerHTML
    removeElementsForSummary(root)
    const summary = root.outerHTML

    logger.success(name, `Successfully processed ${filePath} !`)

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
 * Replace LaTeX image references in the HTML tree with resolved image sources.
 *
 * @param {Resolver} resolver - The resolver for creating absolute paths.
 * @param {HTMLElement} root - The root of the HTML tree.
 * @param {string} texFilePath - The path of the LaTeX file from the content directory.
 * @param {string} moduleDataDirectoryPath - The absolute path to the module directory.
 * @param {string} assetsDirectoryPath - The absolute path to the asset directory.
 * @param {string} sourceDirectoryPath - The absolute path to the source directory.
 * @param {string} contentDirectoryPath - The absolute path to the content directory.
 */
const replaceImages = (
  resolver: Resolver,
  root: HTMLElement,
  texFilePath: string,
  moduleDataDirectoryPath: string,
  assetsDirectoryPath: string,
  sourceDirectoryPath: string,
  contentDirectoryPath: string
) => {
  // Possible image file extensions.
  const extensions = ['', '.svg', '.tex', '.pdf', '.png', '.jpeg', '.jpg', '.gif']

  // Select all image elements in the HTML tree.
  const images = root.querySelectorAll('img')

  // Process each image element.
  for (const image of images) {
    // Get the source attribute of the image.
    const src = image.getAttribute('src')

    // Skip if the source attribute is missing.
    if (!src) {
      continue
    }

    // Directories to search for the image.
    const directories = siteContentSettings.getIncludeGraphicsDirectories(texFilePath)

    // Try resolving the image from various directories and extensions.
    for (const directory of directories) {
      let resolved = false

      // Try different file extensions.
      for (const extension of extensions) {
        // Get the destination path of the image in the assets directory.
        const filePath = siteContentSettings.getLatexAssetDestination(assetsDirectoryPath, directory + '/' + src + extension)

        // Resolve the image source.
        const resolvedSrc = resolveImageSrc(
          filePath,
          directories.map(includedGraphicDirectory => resolver.resolve(contentDirectoryPath, includedGraphicDirectory)),
          assetsDirectoryPath,
          resolver.resolve(sourceDirectoryPath, siteContentSettings.previousBuildDownloadDirectory, path.dirname(path.relative(moduleDataDirectoryPath, filePath)))
        )

        // Format the resolved source as an absolute path.
        if (resolvedSrc) {
          // Update the image source and alt attribute.
          image.setAttribute('src', resolvedSrc.src)
          if (resolvedSrc.dark) {
            image.setAttribute('data-src-dark', resolvedSrc.dark)
          }
          image.setAttribute('alt', getFileName(src))

          resolved = true
          logger.success(name, `Resolved image ${src} to ${resolvedSrc.src} in ${texFilePath}.`)
          break
        }
      }

      // Break the outer loop if the image is resolved.
      if (resolved) {
        break
      }
    }
  }
}

/**
 * Resolve the source of an image file.
 *
 * @param {string} imagePath - The path to the image file.
 * @param {string[]} includeGraphicsDirectories - Directories for including graphics.
 * @param {string} assetsDestinationDirectoryPath - The destination directory for assets.
 * @param {string} cacheDirectoryPath - The path to the cache directory.
 * @returns { {src: string, dark: string | null} | null} - The resolved source of the image or null if not resolved.
 */
const resolveImageSrc = (
  imagePath: string,
  includeGraphicsDirectories: string[],
  assetsDestinationDirectoryPath: string,
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  cacheDirectoryPath: string
): { src: string, dark: string | null } | null => {
  const result = []
  for (const suffix of ['', '-dark']) {
    // Build the image path with suffix.
    const extension = path.extname(imagePath)
    let imagePathWithSuffix = path.resolve(path.dirname(imagePath), getFileName(imagePath) + suffix + extension)
    if (!fs.existsSync(imagePathWithSuffix)) {
      result.push(null)
      continue
    }

    // Check if the image has a TEX extension.
    if (extension === '.tex') {
      // Generate an SVG from the PDF.
      const { builtFilePath } = latex.generateSvg(
        imagePathWithSuffix,
        {
          includeGraphicsDirectories,
          // cacheDirectory: cacheDirectoryPath,
          optimize: true
        }
      )

      // If the PDF couldn't be converted to SVG, return null.
      if (!builtFilePath) {
        result.push(null)
        continue
      }

      // Update the image path to the generated SVG.
      imagePathWithSuffix = builtFilePath
    } else if (extension === '.pdf') {
      imagePathWithSuffix = latex.pdftocairo(path.dirname(imagePathWithSuffix), path.basename(imagePathWithSuffix))
    }

    // Return the relative path from the assets destination directory.
    result.push('/' + path.relative(path.dirname(assetsDestinationDirectoryPath), imagePathWithSuffix).replace(/\\/g, '/'))
  }

  if (result.length === 0 || !result[0]) {
    return null
  }
  return { src: result[0], dark: result.length >= 2 ? result[1] : null }
}

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
 * Add some data attributes to the HTML content.
 *
 * @param {HTMLElement} root - The root HTML element.
 */
function addDataAttributes (root: HTMLElement) {
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
 * Render LaTeX math equations using KaTeX and replace corresponding HTML elements.
 *
 * @param {HTMLElement} root - The root HTML element.
 */
const renderMath = (root: HTMLElement) => {
  const mathElements = root.querySelectorAll('eq')
  for (const mathElement of mathElements) {
    // Get the trimmed text content.
    const latex = replaceLineBreaks(mathElement.text.trim())
    // Determine if it's a display math environment.
    const displayMode = mathElement.getAttribute('env') === 'displaymath'
    // Replace the math element with the rendered KaTeX HTML.
    const renderedMath = katex.renderToString(latex, {
      displayMode,
      output: 'html',
      trust: true,
      strict: (errorCode: any) => errorCode === 'htmlExtension' ? 'ignore' : 'warn',
      macros: {
        '\\parallelslant': '\\mathbin{\\!/\\mkern-5mu/\\!}',
        '\\ensuremath': '#1'
      }
    })
    mathElement.replaceWith(`<span class="math-rendered" data-latex="${latex}" data-latex-display="${displayMode}">${renderedMath}</span>`)
  }
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
