import { defineNuxtConfig } from 'nuxt/config'
import StylelintPlugin from 'vite-plugin-stylelint'
import eslintPlugin from '@nabla/vite-plugin-eslint'
import 'dotenv/config'
import { site } from './site/site'
import { debug } from './site/debug'

// https://v3.nuxtjs.org/api/configuration/nuxt.config
export default defineNuxtConfig({
  ssr: true,

  app: {
    head: {
      titleTemplate: `%s | ${site.name}`,
      htmlAttrs: {
        lang: 'fr'
      },
      meta: [
        { name: 'description', content: site.description },
        { name: 'theme-color', content: '#23618a' }
      ],
      link: [
        { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
      ]
    }
  },

  css: [
    '~/assets/app.scss',
    '~/node_modules/katex/dist/katex.min.css'
  ],

  vite: {
    plugins: [
      StylelintPlugin(),
      eslintPlugin()
    ]
  },

  modules: [
    '~/modules/commit-sha-file-generator',
    'nuxt-cname-generator',
    '~/modules/latex-pdf-generator',
    '~/modules/nuxt-content-latex',
    '~/modules/api-v2-generator',
    '@nuxtjs/sitemap',
    'nuxt-simple-robots',
    'nuxt-link-checker',
    'skimple-components/nuxt',
    '@nuxt/content',
    '@nuxtjs/google-fonts'
  ],

  content: {
    watch: false,
    ignores: [
      ...'log,aux,dvi,lof,lot,bit,idx,glo,bbl,bcf,ilg,toc,ind,out,blg,fdb_latexmk,fls,run.xml,synctex.gz,snm,nav,sta,pdf,checksums'
        .split(',')
        .map(extension => `\\.${extension}$`),
      '/latex/images/',
      '/latex/lessons/common.tex',
      '/latex/lessons/pandoc.tex'
    ]
  },

  googleFonts: {
    display: 'swap',
    families: {
      Handlee: true
    }
  },

  skimpleComponents: {
    bootstrapCss: false,
    bootstrapJs: false
  },

  site: {
    url: site.host,
    name: site.name,
    trailingSlash: true
  },

  cname: {
    host: site.host
  },

  linkChecker: {
    failOnError: false,
    excludeLinks: [
      '/pdf/**'
    ]
  },

  runtimeConfig: {
    public: {
      debug
    }
  }
})
