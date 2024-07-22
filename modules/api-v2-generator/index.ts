import * as fs from 'fs'
import { createResolver, defineNuxtModule, useLogger } from '@nuxt/kit'
import { levels as levelsData } from '../../site/site'
import {
  apiDirectory,
  type ApiLevel,
  mainEndpoint,
  moduleName
} from './common'

/**
 * The logger instance.
 */
const logger = useLogger(moduleName)

/**
 * Nuxt module to generate API v2 files from levels.
 */
export default defineNuxtModule({
  meta: {
    name: moduleName,
    version: '0.0.1',
    compatibility: { nuxt: '^3.0.0' }
  },
  setup: (_, nuxt) => {
    const resolver = createResolver(import.meta.url)

    // Update Nitro config.
    nuxt.hook('nitro:config', (config) => {
      config.plugins = config.plugins || []
      config.plugins.push(resolver.resolve('plugin'))
    })

    // Create API levels.
    const levels: ApiLevel[] = Object.values(levelsData).map((level) => {
      return {
        ...level,
        lessons: `/api/v2/${level.id}/`
      }
    })
    levels.sort((a, b) => a.order - b.order)

    // Create the API index.
    const apiDirectoryPath = resolver.resolve(nuxt.options.srcDir, apiDirectory)
    fs.mkdirSync(apiDirectoryPath, { recursive: true })
    fs.writeFileSync(resolver.resolve(apiDirectoryPath, 'index.json'), JSON.stringify(mainEndpoint(levels)))

    // Add everything to Nitro.
    nuxt.options.nitro.publicAssets = nuxt.options.nitro.publicAssets || []
    nuxt.options.nitro.publicAssets.push({
      baseURL: '/api/v2',
      dir: apiDirectoryPath,
      fallthrough: true
    })

    logger.success('Will generate API v2 files.')
  }
})
