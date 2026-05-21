// noinspection ES6PreferShortImport

import path from 'path'

/**
 * Represents settings for handling the conversion of LaTeX files to HTML and PDF.
 * @interface
 */
interface SiteContentSettings {
  /**
   * Directory path to download the previous build.
   * @type {string}
   */
  previousBuildDownloadDirectory: string

  /**
   * Directory path for assets data files.
   * @type {string}
   */
  dataAssetsDirectory: string

  /**
   * Directory path for LaTeX data files.
   * @type {string}
   */
  dataLatexDirectory: string

  /**
   * Directory path for storing LaTeX PDF files.
   * @type {string}
   */
  latexPdfDestinationDirectory: string

  /**
   * Directory path for storing LaTeX assets.
   * @type {string}
   */
  latexAssetsDestinationDirectory: string

  /**
   * Function to determine whether a file is an asset.
   * @type {(filePath: string) => boolean}
   */
  isAsset: (filePath: string) => boolean

  /**
   * Function to get the destination for LaTeX assets.
   * @type {(assetDirectoryPath: string, filePath: string) => string}
   */
  getLatexAssetDestination: (assetDirectoryPath: string, filePath: string) => string

  /**
   * Redefinitions for Pandoc.
   * @type {string}
   */
  pandocRedefinitions: string

  /**
   * List of file paths to ignore during conversion.
   * @type {string[]}
   */
  ignores: string[]

  /**
   * Function to get directories for includegraphics in LaTeX files.
   * @type {(latexFilePath: string) => string[]}
   */
  getIncludeGraphicsDirectories: (latexFilePath: string) => string[]
}

/**
 * Object containing site content settings.
 * @const {SiteContentSettings}
 * @export
 */
export const siteContentSettings: SiteContentSettings = {
  previousBuildDownloadDirectory: 'node_modules/.previous-build',
  dataAssetsDirectory: 'latex/images/lessons',
  dataLatexDirectory: 'latex/lessons',
  latexPdfDestinationDirectory: 'pdf',
  latexAssetsDestinationDirectory: 'img',
  getLatexAssetDestination: (assetsDirectoryPath: string, filePath: string): string => {
    if (path.basename(filePath) === 'common.tex') {
      return path.resolve(assetsDirectoryPath, 'lessons', 'common.tex')
    }

    const parentDirectoryPath = path.dirname(filePath)
    const levelDirectoryPath = path.dirname(parentDirectoryPath)
    const levelParentDirectoryPath = path.dirname(levelDirectoryPath)
    return path.resolve(
      assetsDirectoryPath,
      path.basename(levelParentDirectoryPath),
      path.basename(levelDirectoryPath),
      path.basename(parentDirectoryPath),
      path.parse(filePath).base
    )
  },
  isAsset: (filePath: string) => ['.tex', '.pdf', '.svg', '.png', '.jpeg', '.jpg', '.gif'].includes(path.parse(filePath).ext),
  pandocRedefinitions: 'pandoc.tex',
  ignores: [
    'common.tex',
    'pandoc.tex'
  ],
  getIncludeGraphicsDirectories: (latexFilePath: string): string[] => [
    path.resolve(path.dirname(latexFilePath), siteContentSettings.latexAssetsDestinationDirectory, path.parse(latexFilePath).name),
    path.dirname(latexFilePath)
  ]
}
