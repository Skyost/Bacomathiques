import * as fs from 'fs'
import { createResolver, defineNuxtModule, useLogger } from '@nuxt/kit'
import { levels as levelsData } from '../../app/site/site'
import { apiDirectory, type ApiLevel, mainEndpoint, moduleName } from './common'
import { generateLessonApiFiles } from './plugin'

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
    compatibility: { nuxt: '^4.0.0' }
  },
  setup: (_, nuxt) => {
    const resolver = createResolver(import.meta.url)
    const apiDirectoryPath = resolver.resolve(nuxt.options.rootDir, apiDirectory)

    fs.rmSync(apiDirectoryPath, { recursive: true, force: true })
    if (!nuxt.options.dev) {
      fs.rmSync(resolver.resolve(nuxt.options.rootDir, '.data/content/contents.sqlite'), { force: true })
    }

    // Create API levels.
    const levels: ApiLevel[] = Object.values(levelsData).map((level) => {
      return {
        ...level,
        lessons: `/api/v2/${level.id}/`
      }
    })
    levels.sort((a, b) => a.order - b.order)

    // Create the API index.
    fs.mkdirSync(apiDirectoryPath, { recursive: true })
    fs.writeFileSync(resolver.resolve(apiDirectoryPath, 'index.json'), JSON.stringify(mainEndpoint(levels)))

    nuxt.hook('content:file:afterParse', ({ file, content, collection }) => {
      if (collection.name !== 'lessons' || file.extension !== '.tex') {
        return
      }
      generateLessonApiFiles(content, nuxt.options.rootDir)
    })

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
