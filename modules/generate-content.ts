import path, { dirname } from 'path'
import fs from 'fs'
import { execSync } from 'child_process'
import { HTMLElement, parse } from 'node-html-parser'
import katex from 'katex'
import mkdirp from 'mkdirp'
import GithubSlugger from 'github-slugger'
import { createResolver, defineNuxtModule, Resolver } from '@nuxt/kit'
import * as matter from 'gray-matter'
import { normalize } from '../utils/utils'
import logger from '../utils/logger'

// TODO: Cache system.
// TODO: Fix all displaystyles.

const name = 'generate-content'
export default defineNuxtModule({
  meta: {
    name,
    version: '0.0.1',
    compatibility: { nuxt: '^3.0.0-rc.10' },
    configKey: 'contentGenerator'
  },
  defaults: {
    srcDir: 'latex/',
    destDir: 'content/generated/',
    pdfDir: 'public/pdf/',
    pandocRedefinitions: 'latex/pandoc.tex',
    ignored: ['latex/common.tex'],
    imagesDir: 'latex/images',
    imagesDestDir: 'public/img/',
    lessonsDir: 'lessons',
    summariesDir: 'summaries'
  },
  setup: async (options, nuxt) => {
    const resolver = createResolver(import.meta.url)

    const ignored = options.ignored.map(file => resolver.resolve(nuxt.options.rootDir, file))
    ignored.push(resolver.resolve(nuxt.options.rootDir, options.pandocRedefinitions))
    ignored.push(resolver.resolve(nuxt.options.rootDir, options.imagesDir))

    const proceededFiles = await processFiles(
      resolver,
      ignored,
      resolver.resolve(nuxt.options.rootDir, options.pandocRedefinitions),
      resolver.resolve(nuxt.options.rootDir, options.srcDir),
      resolver.resolve(nuxt.options.rootDir, options.destDir),
      resolver.resolve(nuxt.options.rootDir, options.pdfDir),
      options.lessonsDir,
      options.summariesDir
    )

    await handleImages(
      resolver,
      resolver.resolve(nuxt.options.rootDir, options.imagesDir),
      resolver.resolve(nuxt.options.rootDir, options.imagesDestDir)
    )

    const filePath = resolver.resolve(
      nuxt.options.srcDir,
      'node_modules/.cache/.contentGenerator/proceededFiles.json'
    )
    mkdirp.sync(dirname(filePath))
    fs.writeFileSync(filePath, JSON.stringify(proceededFiles))
  }
})

async function processFiles (
  resolver: Resolver,
  ignored: Array<string>,
  pandocRedefinitions: string,
  directory: string,
  mdDir: string,
  pdfDir: string,
  lessonsDir: string,
  summariesDir: string
) : Promise<Array<string>> {
  const proceededFiles = []
  const files = fs.readdirSync(directory)
  for (const file of files) {
    const filePath = resolver.resolve(directory, file)
    if (ignored.includes(filePath)) {
      continue
    }
    if (fs.lstatSync(filePath).isDirectory()) {
      const result = await processFiles(resolver, ignored, pandocRedefinitions, filePath, resolver.resolve(mdDir, file), resolver.resolve(pdfDir, file), lessonsDir, summariesDir)
      proceededFiles.push(...result)
    } else if (file.endsWith('.tex')) {
      logger.info(name, `Processing "${filePath}"...`)
      const fileName = getFileName(file)
      const resultFile = resolver.resolve(mdDir, `${fileName}.md`)
      if (!fs.existsSync(resultFile)) {
        const htmlContent = execSync(`pandoc "${path.relative(directory, pandocRedefinitions)}" "${filePath}" -f latex-auto_identifiers -t html --gladtex --shift-heading-level-by=1 --html-q-tags --wrap=preserve`, {
          cwd: directory,
          encoding: 'utf-8'
        })
        const root = parse(htmlContent)
        addIdentifiersToTitles(root)
        renderMath(root)
        addVueComponents(root)
        mkdirp.sync(mdDir)
        const header = getHeader(root)
        fs.writeFileSync(resultFile, toString(root, header))
        if (mdDir.includes(lessonsDir)) {
          const summaryDir = resolver.resolve(mdDir.replace(lessonsDir, summariesDir))
          mkdirp.sync(summaryDir)
          // root = parse(html)
          removeUnnecessaryElements(root)
          fs.writeFileSync(resolver.resolve(summaryDir, `${fileName}.md`), toString(root, header))
        }
      }
      proceededFiles.push(resultFile)
      const lessonPdfFile = resolver.resolve(pdfDir, `${fileName}.pdf`)
      if (!fs.existsSync(lessonPdfFile)) {
        mkdirp.sync(pdfDir)
        execSync(`latexmk -lualatex "${file}"`, { cwd: directory })
        fs.copyFileSync(resolver.resolve(directory, `${fileName}.pdf`), lessonPdfFile)
        execSync('latexmk -quiet -c', { cwd: directory })
      }
    }
  }
  return proceededFiles
}

function addIdentifiersToTitles (root: HTMLElement) {
  const slugger = new GithubSlugger()
  const titles = root.querySelectorAll('h2, h3')
  for (const title of titles) {
    title.setAttribute('id', normalize(slugger.slug(title.text, false)))
  }
}

function renderMath (root: HTMLElement) {
  const mathElements = root.querySelectorAll('eq')
  for (const mathElement of mathElements) {
    const latex = mathElement.text.trim()
    const displayMode = mathElement.getAttribute('env') === 'displaymath'
    const renderedMath = katex.renderToString(latex, {
      displayMode,
      output: 'html',
      trust: true,
      strict: (errorCode: string) => errorCode === 'htmlExtension' ? 'ignore' : 'warn'
    })
    mathElement.replaceWith(`<span class="math-rendered" data-latex="${latex}" data-latex-display="${displayMode}">${renderedMath}</span>`)
  }
}

function addVueComponents (root: HTMLElement) {
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
      let contentWidthAttribute = null
      if (contentWidth) {
        contentWidthAttribute = ` content-width="${contentWidth.textContent.trim()}"`
        contentWidth.remove()
      }
      bubble.replaceWith(`<bubble id="${variant}-${variantCount}" variant="${variant}"${contentWidthAttribute || ''}>${bubble.innerHTML}</bubble>`)
      variantCount++
    }
  }
  const representations = root.querySelectorAll('.geogebra-representation')
  for (const representation of representations) {
    const id = representation.rawText.trim()
    representation.replaceWith(`<representation geogebra-id="${id}"></representation>`)
  }
  const paths = root.querySelectorAll('path')
  for (const path of paths) {
    path.replaceWith(`<svg-path d="${path.getAttribute('d')}"></svg-path>`)
  }
}

function removeUnnecessaryElements (root: HTMLElement) {
  const elements = root.querySelectorAll('bubble[variant="tip"], bubble[variant="proof"], .no-summary')
  for (const element of elements) {
    element.remove()
  }
}

async function handleImages (resolver: Resolver, imagesDir: string, imagesDestDir: string) {
  const files = fs.readdirSync(imagesDir)
  for (const file of files) {
    const filePath = resolver.resolve(imagesDir, file)
    if (fs.lstatSync(filePath).isDirectory()) {
      await handleImages(resolver, filePath, resolver.resolve(imagesDestDir, file))
    } else if (file.endsWith('.tex')) {
      logger.info(name, `Handling image "${filePath}"...`)
      const fileName = getFileName(file)
      const imageSvgFile = resolver.resolve(imagesDestDir, `${fileName}.svg`)
      if (!fs.existsSync(imageSvgFile)) {
        execSync(`latexmk -quiet -pdf "${file}"`, { cwd: imagesDir })
        execSync(`pdftocairo -svg "${fileName}.pdf" "${fileName}.svg"`, { cwd: imagesDir })
        mkdirp.sync(imagesDestDir)
        fs.copyFileSync(resolver.resolve(imagesDir, `${fileName}.svg`), imageSvgFile)
      }
    } else if (file.endsWith('.png')) {
      fs.copyFileSync(resolver.resolve(imagesDir, file), resolver.resolve(imagesDestDir, file))
    }
  }
}

function getFileName (file: string) {
  const extension = file.substring(file.lastIndexOf('.'))
  return path.basename(file).substring(0, file.length - extension.length)
}

function getHeader (root: HTMLElement) {
  const yamlHeader : { [key: string]: string } = {}
  const headers = root.querySelectorAll('.document-header')
  for (const header of headers) {
    const content = header.querySelector('p')
    if (content && content.innerHTML.trim().length > 0) {
      const h2 = header.querySelector('h2')
      if (h2) {
        const id = h2.innerHTML
        yamlHeader[id] = content.innerHTML
      }
    }
    header.remove()
  }
  return yamlHeader
}

function toString (root: HTMLElement, header = getHeader(root)) {
  return matter.stringify(root.innerHTML, header)
}
