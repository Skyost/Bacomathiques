// noinspection ES6PreferShortImport

import path from 'path'
import fs from 'fs'
import { execSync } from 'child_process'
import { optimize, type PluginConfig } from 'svgo'
import type { XastElement, XastParent, XastRoot } from 'svgo/lib/types'
import { debug } from '../site/debug'
import { generateChecksum, getFileName } from './utils'
import * as logger from './logger'

/**
 * Extension of checksums files.
 */
const checksumsExtension = '.checksums'

/**
 * Interface for options when generating a PDF or a SVG.
 */
export interface GenerateOptions {
  /**
   * If true, generate the PDF even if it already exists.
   */
  generateIfExists?: boolean
  /**
   * Directory to find cached generated files.
   */
  cacheDirectory?: string
  /**
   * The cached file name.
   */
  cachedFileName?: string
  /**
   * If true, clean auxiliary files after compilation.
   */
  clean?: boolean
  /**
   * Directories to search for graphics files.
   */
  includeGraphicsDirectories?: string[]
}

/**
 * Options for generating SVGs.
 */
export interface SvgGenerateOptions extends GenerateOptions {
  /**
   * Whether to compress the SVG.
   */
  optimize?: boolean
}

/**
 * Interface for the result of a file generation operation.
 */
export interface GenerateResult {
  /**
   * Path to the generated file or null if generation fails.
   */
  builtFilePath: string | null
  /**
   * Indicates whether the file was retrieved from the cache.
   */
  wasCached: boolean
}

/**
 * Interface for the result of PDF generation.
 */
export interface PdfGenerateResult extends GenerateResult {
  /**
   * Path to the checksums file or null if generation fails.
   */
  checksumsFilePath: string | null
}

/**
 * Interface for caching information.
 */
interface CacheResult {
  /**
   * Indicates whether the file and its checksums are fully cached.
   */
  isFullyCached: boolean
  /**
   * Checksums of the file and its dependencies.
   */
  checksums: string
  /**
   * Path to the cached PDF file.
   */
  cachedPdfFilePath: string
  /**
   * Path to the cached checksums file.
   */
  cachedChecksumsFilePath: string
}

/**
 * Interface defining a LaTeX inclusion command configuration.
 */
interface LatexIncludeCommand {
  /**
   * LaTeX command for inclusion.
   */
  command: string
  /**
   * Directories to search for files related to this command.
   */
  directories: (string | null)[]
  /**
   * Possible file extensions for this command.
   */
  extensions: string[]
  /**
   * File names to exclude for this command.
   */
  excludes: string[]
  /**
   * Indicates whether the command involves nested includes.
   */
  hasIncludes: boolean
  /**
   * Indicates whether the target of the command is a directory.
   */
  targetIsDirectory: boolean
}

/**
 * Type definition for checksums.
 */
type Checksums = { [key: string]: string | Checksums }

/**
 * Generates a PDF file from a LaTeX source file.
 *
 * @param {string} texFilePath - Path to the main LaTeX file.
 * @param {GenerateOptions} options - Generation options.
 * @returns {PdfGenerateResult} - Result of PDF generation.
 */
export const generatePdf = (texFilePath: string, options: GenerateOptions = {}): PdfGenerateResult => {
  // Extract the file name and directory from the given LaTeX file path.
  const fileName = getFileName(texFilePath)
  const directory = path.dirname(texFilePath)

  // Initialize the path to the PDF file.
  let pdfFilePath: string | null = path.resolve(directory, `${fileName}.pdf`)

  // Determine if PDF generation should occur even if the file already exists.
  const generateIfExists = options && options.generateIfExists !== undefined ? options.generateIfExists : !debug

  // Initialize the path to the checksums file.
  const checksumsFilePath = path.resolve(directory, `${fileName}${checksumsExtension}`)

  // Check if the PDF file exists and generation is not forced.
  if (fs.existsSync(pdfFilePath) && !generateIfExists) {
    // If the checksums file does not exist, generate and save checksums.
    if (!fs.existsSync(checksumsFilePath)) {
      fs.writeFileSync(
        checksumsFilePath,
        JSON.stringify(calculateTexFileChecksums(texFilePath, options.includeGraphicsDirectories)),
        { encoding: 'utf8' }
      )
    }
    // Return information indicating that the file was retrieved from the cache.
    return { builtFilePath: pdfFilePath, checksumsFilePath, wasCached: true }
  }

  // Retrieve cache information if caching is enabled.
  const cacheResult = options.cacheDirectory ? getCacheInfo(texFilePath, options) : null

  // Check if the file and its checksums are fully cached.
  if (cacheResult && cacheResult.isFullyCached) {
    // Ensure the directory structure exists.
    fs.mkdirSync(directory, { recursive: true })
    // Copy the cached PDF and checksums files to the working directory.
    fs.copyFileSync(cacheResult.cachedPdfFilePath, pdfFilePath)
    fs.copyFileSync(cacheResult.cachedChecksumsFilePath, checksumsFilePath)
    // Return information indicating that the file was retrieved from the cache.
    return { builtFilePath: pdfFilePath, checksumsFilePath, wasCached: true }
  }

  // Generate the PDF file using latexmk.
  pdfFilePath = latexmk(directory, `${fileName}.tex`, options.clean ?? true)

  // If PDF generation is successful, save the checksums and clean auxiliary files.
  if (pdfFilePath) {
    fs.writeFileSync(
      checksumsFilePath,
      cacheResult?.checksums ?? JSON.stringify(calculateTexFileChecksums(texFilePath, options.includeGraphicsDirectories)),
      { encoding: 'utf8' }
    )
    execSync('latexmk -quiet -c', { cwd: directory })
  }

  // Return information about the generated PDF file.
  return { builtFilePath: pdfFilePath, checksumsFilePath: pdfFilePath == null ? null : checksumsFilePath, wasCached: false }
}

/**
 * Generates an SVG file from a LaTeX source file.
 *
 * @param {string} texFilePath - Path to the main LaTeX file.
 * @param {GenerateOptions} options - Generation options.
 * @returns {GenerateResult} - Result of SVG generation.
 */
export const generateSvg = (texFilePath: string, options: SvgGenerateOptions = { optimize: true }): GenerateResult => {
  // Extract the file name and directory from the given LaTeX file path.
  const fileName = getFileName(texFilePath)
  const directory = path.dirname(texFilePath)

  // Initialize the path to the SVG file.
  let svgFilePath = path.resolve(directory, `${fileName}.svg`)

  // Determine if SVG generation should occur even if the file already exists.
  const generateIfExists = options && options.generateIfExists !== undefined ? options.generateIfExists : !debug

  // Check if the SVG file exists and generation is not forced.
  if (fs.existsSync(svgFilePath) && !generateIfExists) {
    // Return information indicating that the file was retrieved from the cache.
    return { builtFilePath: svgFilePath, wasCached: true }
  }

  // Generate the PDF file, if not cached.
  const pdfGenerateResult = generatePdf(texFilePath, options)

  // If PDF generation fails, return information about the failure.
  if (!pdfGenerateResult.builtFilePath) {
    return { builtFilePath: null, wasCached: false }
  }

  // Convert the PDF file to SVG using pdftocairo.
  if (!pdfGenerateResult.wasCached || !fs.existsSync(svgFilePath)) {
    svgFilePath = pdftocairo(path.dirname(pdfGenerateResult.builtFilePath), `${fileName}.pdf`)
    if (svgFilePath && options.optimize) {
      const svgContent = fs.readFileSync(svgFilePath, { encoding: 'utf8' })
      const size = fs.statSync(svgFilePath).size
      const { data: optimizedSvgContent } = optimize(svgContent, {
        path: svgFilePath,
        multipass: true,
        floatPrecision: size >= 100000 ? 2 : 5,
        plugins: [
          {
            name: 'preset-default',
            params: {
              overrides: {
                removeViewBox: false
              }
            }
          },
          forceUnit
        ]
      })
      fs.writeFileSync(svgFilePath, optimizedSvgContent)
    }
  }

  // Return information about the generated SVG file.
  return { builtFilePath: svgFilePath, wasCached: pdfGenerateResult.wasCached }
}

/**
 * Calls latexmk to compile a LaTeX file and generate a PDF.
 *
 * @param {string} directory - Working directory.
 * @param {string} texFile - Path to the main LaTeX file.
 * @param {boolean} clean - Whether to clean auxiliary files after compilation.
 * @returns {string | null} - Path to the generated PDF or null on failure.
 */
const latexmk = (directory: string, texFile: string, clean: boolean): string | null => {
  try {
    // Execute latexmk command to compile the LaTeX file using LuaLaTeX.
    execSync(`latexmk -lualatex "${texFile}"`, { cwd: directory })
    // Generate the path to the resulting PDF file.
    const result = path.resolve(directory, `${getFileName(texFile)}.pdf`)

    // If cleaning is enabled, remove auxiliary files after successful compilation.
    if (clean) {
      execSync('latexmk -quiet -c', { cwd: directory })
    }

    // Return the path to the generated PDF file.
    return result
  } catch (ex) {
    // Handle errors during compilation.
    logger.fatal('latexmk', ex)

    // Log additional information from the compilation log if available.
    const logFile = path.resolve(directory, `${getFileName(texFile)}.log`)
    if (fs.existsSync(logFile)) {
      const logString = fs.readFileSync(logFile, { encoding: 'utf8' })
      logger.fatal('latexmk', 'Here is the log:')
      logger.fatal('latexmk', logString)
    }

    // Return null to indicate compilation failure.
    return null
  }
}

/**
 * Converts a PDF file to an SVG file using pdftocairo.
 *
 * @param {string} directory - Working directory.
 * @param {string} pdfFile - Path to the PDF file.
 * @returns {string} - Path to the generated SVG file.
 */
export const pdftocairo = (directory: string, pdfFile: string): string => {
  // Generate the desired SVG file name based on the PDF file name.
  const svgFile = `${getFileName(pdfFile)}.svg`
  // Generate the full path to the SVG file.
  const svgFilePath = path.resolve(directory, svgFile)

  // Check if the SVG file does not already exist.
  if (!fs.existsSync(svgFilePath)) {
    // Execute pdftocairo command to convert the PDF file to SVG.
    execSync(`pdftocairo -svg "${pdfFile}" "${svgFile}"`, { cwd: directory })
  }

  // Return the path to the generated SVG file.
  return svgFilePath
}

/**
 * Retrieves information from the cache if available.
 *
 * @param {string} texFilePath - Path to the main LaTeX file.
 * @param {GenerateOptions} options - The generate options.
 * @returns {CacheResult | null} - Cache information or null if not fully cached.
 */
const getCacheInfo = (texFilePath: string, options: GenerateOptions): CacheResult => {
  // Extract the file name from the given LaTeX file path.
  const fileName = options.cachedFileName ?? getFileName(texFilePath)

  // Calculate the checksums for the current LaTeX file, including graphics directories.
  const checksums = JSON.stringify(calculateTexFileChecksums(texFilePath, options.includeGraphicsDirectories))

  // Generate paths to the cached PDF and checksums files.
  const cachedPdfFilePath = path.resolve(options.cacheDirectory!, `${fileName}.pdf`)
  const cachedChecksumsFilePath = path.resolve(options.cacheDirectory!, `${fileName}${checksumsExtension}`)

  // Check if both the cached PDF and checksums files exist, and if the checksums match the expected values.
  const isFullyCached =
    fs.existsSync(cachedPdfFilePath) &&
    fs.existsSync(cachedChecksumsFilePath) &&
    checksums === fs.readFileSync(cachedChecksumsFilePath, { encoding: 'utf8' })

  // Return the cache information, including the cached file paths and checksums.
  return {
    isFullyCached,
    checksums,
    cachedPdfFilePath,
    cachedChecksumsFilePath
  }
}

/**
 * Calculates checksums for a LaTeX file and its dependencies.
 *
 * @param {string} filePath - Path to the main LaTeX file.
 * @param {string[]} includeGraphicsDirectories - Directories to search for graphics files.
 * @param {string | null} currentDirectory - Current directory (used for relative paths).
 * @returns {Checksums} - Object containing checksums for the file and its dependencies.
 */
const calculateTexFileChecksums = (filePath: string, includeGraphicsDirectories: string[] = [], currentDirectory: string | null = null): Checksums => {
  // If currentDirectory is not provided, use the directory of the LaTeX file.
  currentDirectory ??= path.dirname(filePath)

  // Define LaTeX include commands with their corresponding configurations.
  const latexIncludeCommands: LatexIncludeCommand[] = [
    // includegraphics command for graphics files.
    {
      command: 'includegraphics',
      directories: [null, currentDirectory, ...includeGraphicsDirectories],
      extensions: ['.pdf', '.svg', '.png', '.jpeg', '.jpg'],
      excludes: [],
      hasIncludes: false,
      targetIsDirectory: false
    },
    // include command for other LaTeX files.
    {
      command: 'include',
      directories: [null, currentDirectory],
      extensions: ['.tex'],
      excludes: [],
      hasIncludes: true,
      targetIsDirectory: false
    },
    // input command for other LaTeX files.
    {
      command: 'input',
      directories: [null, currentDirectory],
      extensions: ['.tex'],
      excludes: [],
      hasIncludes: true,
      targetIsDirectory: false
    }
  ]

  // Initialize an object to store checksums.
  const checksums: Checksums = {}

  // Calculate and store the checksum for the main LaTeX file.
  checksums[`file:${getFileName(filePath)}`] = generateChecksum(fs.readFileSync(filePath, { encoding: 'utf8' }))

  // Iterate through each LaTeX include command.
  for (const latexIncludeCommand of latexIncludeCommands) {
    // Define a regular expression based on the current LaTeX include command.
    const regex = new RegExp(`\\\\${latexIncludeCommand.command}(\\[[A-Za-zÀ-ÖØ-öø-ÿ\\d, =.\\\\-]*])?{([A-Za-zÀ-ÖØ-öø-ÿ\\d/, .\\-:_]+)}`, 'gs')

    // Read the content of the LaTeX file.
    const content = fs.readFileSync(filePath, { encoding: 'utf8' })

    // Execute the regular expression on the content.
    let match = regex.exec(content)

    // Iterate through each match found in the content.
    while (match != null) {
      const fileName = match[2]
      const checksumKey = `${latexIncludeCommand.command}:${fileName}`

      // Check if the file should be excluded and if its checksum has not been calculated yet.
      if (!latexIncludeCommand.excludes.includes(fileName) && !(checksumKey in checksums)) {
        // Iterate through each directory for the current LaTeX include command.
        for (const directory of latexIncludeCommand.directories) {
          let includeFile = directory == null ? fileName : path.resolve(directory, fileName)

          // Check if the target is a directory.
          if (latexIncludeCommand.targetIsDirectory) {
            // Check if the directory exists and is a directory.
            if (fs.existsSync(includeFile) && fs.lstatSync(includeFile).isDirectory()) {
              const directoryChecksums: Checksums = {}

              // List files in the directory.
              const files = fs.readdirSync(includeFile)

              // Iterate through each file in the directory.
              for (const file of files) {
                const subKey = `sub:${getFileName(file)}`
                const subPath = path.resolve(includeFile, file)

                // Calculate checksums for files inside the directory.
                if (latexIncludeCommand.hasIncludes) {
                  checksums[subKey] = calculateTexFileChecksums(subPath, includeGraphicsDirectories, currentDirectory)
                } else {
                  checksums[subKey] = generateChecksum(fs.readFileSync(subPath, { encoding: 'utf8' }))
                }
              }
              checksums[checksumKey] = directoryChecksums
            }
          } else {
            // Check each possible extension for the include file.
            const extensions = ['', ...latexIncludeCommand.extensions]
            for (const extension of extensions) {
              const includeFileWithExtension = `${includeFile}${extension}`

              // Check if the file with the extension exists.
              if (fs.existsSync(includeFileWithExtension)) {
                includeFile = includeFileWithExtension
                break
              }
            }

            // Check if the file exists.
            if (fs.existsSync(includeFile)) {
              // Calculate checksums for included files.
              if (latexIncludeCommand.hasIncludes) {
                checksums[checksumKey] = calculateTexFileChecksums(includeFile, includeGraphicsDirectories, currentDirectory)
              } else {
                checksums[checksumKey] = generateChecksum(fs.readFileSync(includeFile, { encoding: 'utf8' }))
              }
              break
            }
          }
        }
      }
      // Continue to the next match.
      match = regex.exec(content)
    }
  }
  // Return the calculated checksums.
  return checksums
}

/**
 * An SVGO plugin that allows to force a given unit on width and height attributes of SVGs.
 */
const forceUnit: PluginConfig = {
  name: 'forceUnit',
  fn: (_root: XastRoot, params: any) => {
    const requiredUnit = params?.unit ?? 'pt'
    const size: {[key: string]: string | null } = { width: null, height: null }
    return {
      element: {
        enter: (node: XastElement, parentNode: XastParent) => {
          if (node.name === 'svg' && parentNode.type === 'root') {
            const viewBox = node.attributes.viewBox
            if (viewBox) {
              const parts = viewBox.split(' ')
              node.attributes.width = parts[2] + requiredUnit
              node.attributes.height = parts[3] + requiredUnit
              return
            }
            const attributes = ['width', 'height']
            for (const attribute of attributes) {
              let value = node.attributes[attribute]
              if (!value || value.endsWith(requiredUnit)) {
                continue
              }
              const unitRegex = /[0-9]+\.?[0-9]*(px|pt|cm|mm|in|em|ex|pc)?/g
              const number = value.replace(unitRegex, match => parseFloat(match).toString())
              size[attribute] = number
              value = number + requiredUnit
              node.attributes[attribute] = value
            }
          }
        }
      }
    }
  }
}
