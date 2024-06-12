import { execSync } from 'child_process'
import fs from 'fs'
import { createResolver, defineNuxtModule, useLogger } from '@nuxt/kit'

/**
 * Options for the commit SHA file generator module.
 *
 * @interface
 */
export interface ModuleOptions {
  /** The name of the file to store the latest commit information. */
  fileName: string;
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
    compatibility: { nuxt: '^3.0.0' }
  },
  defaults: {
    fileName: 'latest-commit.json'
  },
  setup: (options, nuxt) => {
    const resolver = createResolver(import.meta.url)
    const srcDir = nuxt.options.srcDir

    // Retrieve commit hash information.
    const long = execSync('git rev-parse HEAD', { cwd: srcDir }).toString().trim()
    const short = execSync('git rev-parse --short HEAD', { cwd: srcDir }).toString().trim()

    // Write commit information to file.
    fs.writeFileSync(resolver.resolve(srcDir, 'content', options.fileName), JSON.stringify({ long, short }))

    logger.success(`Wrote latest commit info for ${long}.`)
  }
})
