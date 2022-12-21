import * as fs from 'fs'
import { Readable } from 'stream'
import path, { dirname } from 'path'
import mkdirp from 'mkdirp'
import { SitemapStream, streamToPromise } from 'sitemap'
import { defineNuxtModule, createResolver } from '@nuxt/kit'
import { NuxtPage } from '@nuxt/schema'

export default defineNuxtModule({
  meta: {
    name: 'generate-sitemap',
    version: '0.0.1',
    configKey: 'sitemap',
    compatibility: { nuxt: '^3.0.0-rc.10' }
  },
  defaults: {
    hostname: 'http://localhost:3000',
    include: ['/cours/premiere/', '/cours/terminale/'],
    exclude: ['/404'],
    contentGeneratorDestDir: 'content/generated/'
  },
  setup (options, nuxt) {
    function generateSitemap (routes: Array<NuxtPage>, dynamicRoutes: Array<string>) {
      const sitemapRoutes = routes
        .filter(route => !options.exclude.includes(route.path) && !route.path.includes(':'))
        .map(route => route.path)
      sitemapRoutes.push(...dynamicRoutes)

      // https://github.com/ekalinin/sitemap.js#generate-a-one-time-sitemap-from-a-list-of-urls
      const stream = new SitemapStream({ hostname: options.hostname })
      return streamToPromise(Readable.from(sitemapRoutes).pipe(stream)).then(data =>
        data.toString()
      )
    }

    function createSitemapFile (sitemap: string, filepath: string) {
      const dirPath = dirname(filepath)
      mkdirp.sync(dirPath)
      fs.writeFileSync(filepath, sitemap)
    }

    function proceededFileToPageUrl (proceededFile: string) {
      const destDir = resolver.resolve(nuxt.options.rootDir, options.contentGeneratorDestDir)
      let url = proceededFile.substring(destDir.length).split(path.sep).join(path.posix.sep)
      if (url.startsWith('/lessons/')) {
        url = `/cours/${url.substring('/lessons/'.length)}`
      }
      if (url.endsWith('.md')) {
        url = `${url.substring(0, url.length - '.md'.length)}/`
      }
      return url
    }

    const resolver = createResolver(import.meta.url)
    const filePath = resolver.resolve(
      nuxt.options.srcDir,
      'node_modules/.cache/.sitemap/sitemap.xml'
    )

    nuxt.options.nitro.publicAssets = nuxt.options.nitro.publicAssets || []
    nuxt.options.nitro.publicAssets.push({
      baseURL: '/',
      dir: dirname(filePath)
    })

    nuxt.hook('pages:extend', async (pages) => {
      const proceededFiles = resolver.resolve(
        nuxt.options.srcDir,
        'node_modules/.cache/.contentGenerator/proceededFiles.json'
      )
      const dynamicPages = options.include
      if (fs.existsSync(proceededFiles)) {
        const proceededFilesContent = JSON.parse(fs.readFileSync(proceededFiles).toString())
        dynamicPages.push(...proceededFilesContent.map(proceededFileToPageUrl))
      }
      const sitemap = await generateSitemap(pages, dynamicPages)
      createSitemapFile(sitemap, filePath)
    })
  }
})
