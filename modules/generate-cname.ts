import { dirname } from 'path'
import fs from 'fs'
import mkdirp from 'mkdirp'
import { createResolver, defineNuxtModule } from '@nuxt/kit'

export default defineNuxtModule({
  meta: {
    name: 'generate-cname',
    version: '0.0.1',
    configKey: 'cname',
    compatibility: { nuxt: '^3.0.0-rc.10' }
  },
  defaults: {
    hostname: 'localhost:3000'
  },
  setup: (options, nuxt) => {
    const resolver = createResolver(import.meta.url)
    const filePath = resolver.resolve(nuxt.options.srcDir, 'node_modules/.cache/.cname/CNAME')
    const fileDirectory = dirname(filePath)
    if (!fs.existsSync(fileDirectory)) {
      mkdirp.sync(fileDirectory)
    }
    nuxt.options.nitro.publicAssets = nuxt.options.nitro.publicAssets || []
    nuxt.options.nitro.publicAssets.push({
      baseURL: '/',
      dir: dirname(filePath)
    })
    fs.writeFileSync(filePath, new URL(options.hostname).host)
  }
})
