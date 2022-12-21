import fs from 'fs'
import { createResolver, defineNuxtModule, extendPages } from '@nuxt/kit'

export default defineNuxtModule({
  meta: {
    name: 'generate-404',
    version: '0.0.1',
    compatibility: { nuxt: '^3.0.0-rc.10' }
  },
  setup: (_, nuxt) => {
    const resolver = createResolver(import.meta.url)
    const filePath = resolver.resolve(nuxt.options.srcDir, 'pages/404.vue')
    if (fs.existsSync(filePath)) {
      extendPages((pages) => {
        pages.push({
          name: '404',
          path: '/404.html',
          file: filePath
        })
      })
    }
  }
})
