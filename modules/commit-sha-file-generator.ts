import fs from 'fs'
import path from 'path'
import { createResolver, defineNuxtModule, useLogger } from '@nuxt/kit'

/**
 * Options for the commit SHA file generator module.
 *
 * @interface
 */
export interface ModuleOptions {
  /** The name of the file to store the latest commit information. */
  fileName: string
}

/**
 * The name of the commit SHA file generator module.
 */
const name = 'commit-sha-file-generator'

/**
 * The logger instance.
 */
const logger = useLogger(name)

/**
 * Nuxt module to generate a file containing the latest commit hash information.
 */
export default defineNuxtModule<ModuleOptions>({
  meta: {
    name,
    version: '0.0.1',
    configKey: 'commitShaFileGenerator',
    compatibility: { nuxt: '^4.0.0' }
  },
  defaults: {
    fileName: 'latest-commit.json'
  },
  setup: (options, nuxt) => {
    const resolver = createResolver(import.meta.url)
    const rootDir = nuxt.options.rootDir

    // Retrieve commit hash information.
    const long = readGitHead(rootDir)
    const short = long.substring(0, 7)

    // Write commit information to file.
    fs.writeFileSync(resolver.resolve(rootDir, 'content', options.fileName), JSON.stringify({ long, short }))

    logger.success(`Wrote latest commit info for ${long}.`)
  }
})

const readGitHead = (rootDir: string) => {
  const head = fs.readFileSync(path.resolve(rootDir, '.git', 'HEAD'), { encoding: 'utf8' }).trim()
  if (!head.startsWith('ref:')) {
    return head
  }
  const ref = head.substring('ref:'.length).trim()
  return fs.readFileSync(path.resolve(rootDir, '.git', ref), { encoding: 'utf8' }).trim()
}
