// noinspection ES6PreferShortImport

import fs from 'fs'
import path from 'path'
import { createResolver, defineNuxtModule, type Resolver, useLogger } from '@nuxt/kit'
import { Octokit } from '@octokit/core'
import AdmZip from 'adm-zip'
import * as latex from 'that-latex-lib'
import { siteContentSettings } from '../site/content'
import { debug } from '../site/debug'
import { getFileName } from '../utils/utils'
import type { Github } from '../site/site'
import { site } from '../site/site'

/**
 * Options for the PDF generator module.
 *
 * @interface
 */
export interface ModuleOptions {
  github: Github
  directory: string
  previousBuildDownloadDirectory: string
  destinationDirectory: string
  ignores: string[]
  previousBuildDirectories: string[]
  getIncludeGraphicsDirectories: (latexFilePath: string) => string[]
  moveFiles: boolean
}

/**
 * The name of the module.
 */
const name = 'latex-pdf-generator'

/**
 * The logger instance.
 */
const logger = useLogger(name)

/**
 * Nuxt module to compile Latex files into PDF.
 */
export default defineNuxtModule<ModuleOptions>({
  meta: {
    name,
    version: '0.0.1',
    compatibility: { nuxt: '^3.0.0' },
    configKey: 'latexPdfGenerator'
  },
  defaults: {
    github: site.github,
    directory: siteContentSettings.dataLatexDirectory,
    previousBuildDownloadDirectory: siteContentSettings.previousBuildDownloadDirectory,
    destinationDirectory: siteContentSettings.latexPdfDestinationDirectory,
    ignores: siteContentSettings.ignores,
    previousBuildDirectories: [siteContentSettings.latexPdfDestinationDirectory, siteContentSettings.latexAssetsDestinationDirectory],
    getIncludeGraphicsDirectories: siteContentSettings.getIncludeGraphicsDirectories,
    moveFiles: !debug
  },
  setup: async (options, nuxt) => {
    const resolver = createResolver(import.meta.url)
    const srcDir = nuxt.options.srcDir
    const directoryPath = resolver.resolve(srcDir, 'content', options.directory)

    // Download the previous build.
    // This allows to not compile files if they haven't changed.
    let previousBuildDirectoryPath = resolver.resolve(srcDir, options.previousBuildDownloadDirectory)
    const downloadResult = await downloadPreviousBuild(resolver, previousBuildDirectoryPath, options)
    previousBuildDirectoryPath = resolver.resolve(previousBuildDirectoryPath, options.destinationDirectory)

    // And generate all PDFs !
    const ignores = options.ignores.map(file => resolver.resolve(directoryPath, file))
    const moduleDirectoryPath = resolver.resolve(srcDir, 'node_modules', `.${name}`)
    generatePdf(
      resolver,
      directoryPath,
      moduleDirectoryPath,
      ignores,
      downloadResult ? previousBuildDirectoryPath : null,
      options
    )

    // Register all generated files in Nitro.
    nuxt.options.nitro.publicAssets = nuxt.options.nitro.publicAssets || []
    nuxt.options.nitro.publicAssets.push({
      baseURL: `/${options.destinationDirectory}/`,
      dir: moduleDirectoryPath,
      fallthrough: true
    })
  }
})

/**
 * Downloads the previous build from Github pages.
 * @param {Resolver} resolver The resolver instance.
 * @param {string} directoryPath The download destination.
 * @param {ModuleOptions} options The module options.
 * @return {Promise<boolean>} Whether the download is a success.
 */
const downloadPreviousBuild = async (resolver: Resolver, directoryPath: string, options: ModuleOptions): Promise<boolean> => {
  try {
    logger.info(`Downloading and unzipping the previous build at ${options.github.username}/${options.github.repository}@gh-pages...`)
    if (fs.existsSync(directoryPath)) {
      logger.success('Already downloaded.')
      return true
    }
    // We create the Octokit instance.
    const octokit = new Octokit()
    const response = await octokit.request('GET /repos/{owner}/{repo}/zipball/{ref}', {
      owner: options.github.username,
      repo: options.github.repository,
      ref: 'gh-pages'
    })

    // We read the response using AdmZip.
    const zip = new AdmZip(Buffer.from(response.data as Buffer))
    const zipRootDir = zip.getEntries()[0].entryName

    // We extract it to the parent folder.
    const parentPath = path.dirname(directoryPath)
    if (!fs.existsSync(parentPath)) {
      fs.mkdirSync(parentPath, { recursive: true })
    }
    for (const previousBuildCacheDirectory of options.previousBuildDirectories) {
      zip.extractEntryTo(`${zipRootDir}${previousBuildCacheDirectory}/`, parentPath)
    }

    // Then we can rename the main entry into the destination folder name.
    fs.renameSync(resolver.resolve(parentPath, zipRootDir), resolver.resolve(parentPath, path.basename(directoryPath)))
    logger.success('Done.')
    return true
  }
  catch (exception) {
    logger.warn(exception)
  }
  return false
}

/**
 * Recursively generates PDF files from Latex files in a directory.
 *
 * @param {Resolver} resolver The resolver instance.
 * @param {string} directoryPath Absolute path to the directory containing Latex files.
 * @param {string} destinationDirectoryPath Absolute path to the destination directory for generated PDFs.
 * @param {string[]} ignores List of files to ignore during the generation process.
 * @param {string | null} previousBuildDirectory Absolute path to the directory containing previous build files.
 * @param {ModuleOptions} options Module options.
 */
const generatePdf = (
  resolver: Resolver,
  directoryPath: string,
  destinationDirectoryPath: string,
  ignores: string[],
  previousBuildDirectory: string | null,
  options: ModuleOptions
) => {
  // Get a list of files in the current directory.
  const files = fs.readdirSync(directoryPath)

  // Iterate over each file in the directory.
  for (const file of files) {
    const filePath = resolver.resolve(directoryPath, file)

    // Ignore specified files and directories.
    if (ignores.includes(filePath) || !fs.existsSync(filePath)) {
      logger.info(`Ignored ${filePath}.`)
      continue
    }

    // If the file is a directory, recursively generate PDFs for its contents.
    if (fs.lstatSync(filePath).isDirectory()) {
      generatePdf(
        resolver,
        filePath,
        resolver.resolve(destinationDirectoryPath, file),
        ignores,
        previousBuildDirectory == null ? null : resolver.resolve(previousBuildDirectory, file),
        options
      )
      continue
    }

    // If the file has a .tex extension, process it to generate a PDF.
    const extension = path.extname(file)
    if (extension === '.tex') {
      generateAndCopy(resolver, filePath, previousBuildDirectory, destinationDirectoryPath, options)
    }
  }
}

/**
 * Generates and copies a file.
 *
 * @param {Resolver} resolver The resolver instance.
 * @param {string} filePath The file path.
 * @param {string | null} previousBuildDirectory Absolute path to the directory containing previous build files.
 * @param {string} destinationDirectoryPath Absolute path to the destination directory.
 * @param {ModuleOptions} options Module options.
 * @param {string | null} destinationFileName The destination directory.
 * @param {string | null} variant Whether we're generating a variant.
 * @return {boolean} Whether the operation is a success.
 */
const generateAndCopy = (
  resolver: Resolver,
  filePath: string,
  previousBuildDirectory: string | null,
  destinationDirectoryPath: string,
  options: ModuleOptions,
  destinationFileName: string | null = null,
  variant: string | null = null
): boolean => {
  logger.info(`Processing "${filePath}"${variant ?? ''}...`)

  // Generate PDF and checksums files.
  const { wasCached, builtFilePath, checksumsFilePath } = latex.generatePdf(
    filePath,
    {
      includeGraphicsDirectories: options.getIncludeGraphicsDirectories(filePath),
      cacheDirectoryPath: previousBuildDirectory == null ? undefined : previousBuildDirectory,
      cachedFileName: destinationFileName ?? getFileName(filePath)
    }
  )

  // If PDF generation is successful, copy files to the destination directory.
  if (builtFilePath) {
    let parts = path.parse(builtFilePath)
    let fileName = destinationFileName ?? parts.name
    const destinationFilePath = resolver.resolve(destinationDirectoryPath, fileName + parts.ext)
    fs.mkdirSync(destinationDirectoryPath, { recursive: true })
    fs.copyFileSync(builtFilePath, destinationFilePath)

    // Optionally move files instead of copying.
    if (options.moveFiles) {
      fs.unlinkSync(builtFilePath)
    }

    // Copy checksums file if available.
    if (checksumsFilePath) {
      parts = path.parse(checksumsFilePath)
      fileName = destinationFileName ?? parts.name
      fs.copyFileSync(checksumsFilePath, resolver.resolve(destinationDirectoryPath, fileName + parts.ext))

      // Optionally move checksums file instead of copying.
      if (options.moveFiles) {
        fs.unlinkSync(checksumsFilePath)
      }
    }

    if (wasCached) {
      logger.success(`Fully cached PDF found in ${previousBuildDirectory}.`)
    }
    else {
      logger.success(previousBuildDirectory ? `File was not cached in ${previousBuildDirectory} but has been generated with success.` : 'Done.')
    }
    return true
  }
  logger.fatal('Error.')
  return false
}
