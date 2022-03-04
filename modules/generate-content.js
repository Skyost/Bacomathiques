import { parse } from 'node-html-parser'
import { normalize } from '../utils/utils'

const path = require('path')
const fs = require('fs')
const execSync = require('child_process').execSync
const svgson = require('svgson')
const katex = require('katex')
const GithubSlugger = require('github-slugger')
const logger = require('./logger')

// TODO: Cache system.
// TODO: Fix all displaystyles.

module.exports = function () {
  const srcDir = this.options.generateContent.srcDir
  const destDir = this.options.generateContent.destDir
  const pdfDir = this.options.generateContent.pdfDir
  const pandocRedefinitions = this.options.generateContent.pandocRedefinitions
  const imagesDir = this.options.generateContent.imagesDir
  const imagesDestDir = this.options.generateContent.imagesDestDir
  const ignored = this.options.generateContent.ignored.map(file => path.resolve(file))
  ignored.push(path.resolve(pandocRedefinitions))
  ignored.push(path.resolve(imagesDir))
  this.nuxt.hook('build:compile', async function ({ name }) {
    if (name === 'server') {
      await processFiles(ignored, pandocRedefinitions, path.resolve(srcDir), path.resolve(destDir), path.resolve(pdfDir))
      await handleImages(imagesDir, imagesDestDir)
    }
  })
}

async function processFiles (ignored, pandocRedefinitions, directory, mdDir, pdfDir) {
  const files = fs.readdirSync(directory)
  for (const file of files) {
    const filePath = path.resolve(directory, file)
    if (ignored.includes(filePath)) {
      continue
    }
    if (fs.lstatSync(filePath).isDirectory()) {
      await processFiles(ignored, pandocRedefinitions, filePath, path.resolve(mdDir, file), path.resolve(pdfDir, file))
    } else if (file.endsWith('.tex')) {
      logger.info(`Processing "${filePath}"...`)
      const fileName = getFileName(file)
      fs.mkdirSync(mdDir, { recursive: true })
      const htmlContent = execSync(`pandoc "${path.relative(directory, pandocRedefinitions)}" "${filePath}" -f latex-auto_identifiers -t html --gladtex --shift-heading-level-by=1 --html-q-tags --wrap=preserve`, {
        cwd: directory,
        encoding: 'utf-8'
      })
      let root = parse(htmlContent)
      addIdentifiersToTitles(root)
      renderMath(root)
      addVueComponents(root)
      const html = root.innerHTML
      fs.writeFileSync(path.resolve(mdDir, fileName + '.md'), html)
      if (mdDir.includes('lessons')) {
        root = parse(html)
        const summaryDir = path.resolve(mdDir.replace('lessons', 'summaries'))
        fs.mkdirSync(summaryDir, { recursive: true })
        removeUnnecessaryElements(root)
        fs.writeFileSync(path.resolve(summaryDir, fileName + '.md'), root.innerHTML)
      }
      fs.mkdirSync(pdfDir, { recursive: true })
      execSync(`latexmk -pdflatex=lualatex -quiet -pdf "${file}"`, { cwd: directory })
      fs.copyFileSync(path.resolve(directory, `${fileName}.pdf`), path.resolve(pdfDir, `${fileName}.pdf`))
      // execSync(`latexmk -quiet -c`, { cwd: directory })
    }
  }
}

function addIdentifiersToTitles (root) {
  const slugger = new GithubSlugger()
  const titles = root.querySelectorAll('h2, h3')
  for (const title of titles) {
    title.setAttribute('id', normalize(slugger.slug(title.text, false)))
  }
}

function renderMath (root) {
  const mathElements = root.querySelectorAll('eq')
  for (const mathElement of mathElements) {
    const latex = mathElement.text
    const renderedMath = katex.renderToString(latex, {
      displayMode: mathElement.getAttribute('env') === 'displaymath'
      // output: 'html'
    })
    mathElement.replaceWith(renderedMath)
  }
}

function addVueComponents (root) {
  const variants = ['formula', 'tip', 'proof']
  for (const variant of variants) {
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
      bubble.replaceWith(`<bubble variant="${variant}"${contentWidthAttribute || ''}>${bubble.innerHTML}</bubble>`)
    }
  }
  const representations = root.querySelectorAll('.geogebra-representation')
  for (const representation of representations) {
    const id = representation.rawText.trim()
    representation.replaceWith(`<representation geogebra-id="${id}"></representation>`)
  }
}

function removeUnnecessaryElements (root) {
  const bubbles = root.querySelectorAll('bubble')
  for (const bubble of bubbles) {
    const variant = bubble.getAttribute('variant')
    if (variant === 'tip' || variant === 'proof') {
      bubble.remove()
    }
  }
  const noSummaryElements = root.querySelectorAll('.no-summary')
  for (const noSummaryElement of noSummaryElements) {
    noSummaryElement.remove()
  }
}

async function handleImages (imagesDir, imagesDestDir) {
  const files = fs.readdirSync(imagesDir)
  for (const file of files) {
    const filePath = path.resolve(imagesDir, file)
    if (fs.lstatSync(filePath).isDirectory()) {
      await handleImages(filePath, path.resolve(imagesDestDir, file))
    } else if (file.endsWith('.tex')) {
      logger.info(`Handling image "${filePath}"...`)
      const fileName = getFileName(file)
      execSync(`latexmk -quiet -pdf "${file}"`, { cwd: imagesDir })
      execSync(`pdftocairo -svg "${fileName}.pdf" "${fileName}.svg"`, { cwd: imagesDir })
      fs.mkdirSync(imagesDestDir, { recursive: true })
      fs.copyFileSync(path.resolve(imagesDir, `${fileName}.svg`), path.resolve(imagesDestDir, `${fileName}.svg`))
    } else if (file.endsWith('.png')) {
      fs.copyFileSync(path.resolve(imagesDir, file), path.resolve(imagesDestDir, file))
    }
  }
}

function getFileName (file) {
  const extension = file.substring(file.lastIndexOf('.'))
  return path.basename(file).substring(0, file.length - extension.length)
}
