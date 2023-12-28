import { dirname } from 'path'
import fs from 'fs'
import { createResolver, defineNuxtModule } from '@nuxt/kit'
import * as logger from '../utils/logger'

/**
 * Options for the CNAME generator module.
 *
 * @interface
 */
export interface ModuleOptions {
  /**
   * The hostname to be used in the generated CNAME file.
   */
  hostname: string;
}

/**
 * The name of the CNAME generator module.
 */
const name = 'cname-generator'

/**
 * Nuxt module to generate a CNAME file for GitHub Pages.
 */
export default defineNuxtModule<ModuleOptions>({
  meta: {
    name,
    version: '0.0.1',
    configKey: 'cname',
    compatibility: { nuxt: '^3.0.0' }
  },
  defaults: {
    hostname: 'localhost:3000'
  },
  setup: (options, nuxt) => {
    const resolver = createResolver(import.meta.url)
    const filePath = resolver.resolve(nuxt.options.srcDir, 'node_modules/.cache/cname/CNAME')
    const fileDirectory = dirname(filePath)

    // Create directory if it doesn't exist.
    if (!fs.existsSync(fileDirectory)) {
      fs.mkdirSync(fileDirectory, { recursive: true })
    }

    // Add public asset configuration.
    nuxt.options.nitro.publicAssets = nuxt.options.nitro.publicAssets || []
    nuxt.options.nitro.publicAssets.push({
      baseURL: '/',
      dir: dirname(filePath)
    })

    // Write CNAME file.
    const { host } = new URL(options.hostname)
    fs.writeFileSync(filePath, host)
    logger.success(name, `Generated CNAME for ${host}.`)
  }
})
