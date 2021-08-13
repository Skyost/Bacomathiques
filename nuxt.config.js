import { HOST_NAME, SITE_DESCRIPTION, SITE_NAME } from './utils/site'

export default {
  // Target (https://go.nuxtjs.dev/config-target)
  target: 'static',

  // Global page headers (https://go.nuxtjs.dev/config-head)
  head: {
    htmlAttrs: {
      lang: 'fr'
    },
    titleTemplate: `%s | ${SITE_NAME}`,
    meta: [
      { charset: 'utf-8' },
      { hid: 'description', name: 'description', content: SITE_DESCRIPTION },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { name: 'theme-color', content: '#2489cc' }
    ],
    link: [
      {
        rel: 'stylesheet',
        href: 'https://cdn.jsdelivr.net/npm/katex@0.13.11/dist/katex.min.css',
        integrity: 'sha384-Um5gpz1odJg5Z4HAmzPtgZKdTBHZdw8S29IecapCSB31ligYPhHQZMIlWLYQGVoc',
        crossorigin: 'anonymous'
      },
      { rel: 'stylesheet', href: 'https://cdn.jsdelivr.net/npm/futura-font@1.0.0/styles.min.css' },
      { rel: 'icon', type: 'image/png', href: '/img/favicon.ico' }
    ]
  },

  // Global CSS (https://go.nuxtjs.dev/config-css)
  css: [],

  // Plugins to run before rendering page (https://go.nuxtjs.dev/config-plugins)
  plugins: [
    'plugins/global-components',
    'plugins/mixin-common-methods'
  ],

  // Auto import components (https://go.nuxtjs.dev/config-components)
  components: true,

  // Modules for dev and build (recommended) (https://go.nuxtjs.dev/config-modules)
  buildModules: [
    // https://go.nuxtjs.dev/eslint
    // '@nuxtjs/eslint-module',
    // https://go.nuxtjs.dev/stylelint
    '@nuxtjs/stylelint-module',
    '~/modules/generate-content',
    '~/modules/generate-api-v2',
    '~/modules/sitemap-dynamic-routes'
  ],

  // Modules (https://go.nuxtjs.dev/config-modules)
  modules: [
    '@nuxt/content',
    '@nuxtjs/sitemap',
    '@nuxtjs/robots',
    '@nuxtjs/router-extras',
    '@nuxtjs/recaptcha',
    'bootstrap-vue/nuxt',
    'cookie-universal-nuxt'
  ],

  content: {
    liveEdit: false,
    nestedProperties: [
      'lessons.lesson',
      'lessons.level'
    ]
  },

  googleFonts: {
    display: 'swap',
    families: {
      Handlee: true
    }
  },

  robots: {
    UserAgent: '*',
    Disallow: ['/api/', '/_nuxt/'],
    Sitemap: `${HOST_NAME}/sitemap.xml`
  },

  sitemap: {
    hostname: HOST_NAME,
    defaults: {
      priority: 1,
      lastmod: new Date()
    }
  },

  recaptcha: {
    hideBadge: true,
    siteKey: '6LeRTxQaAAAAALJfP1vHXGqsejwTSDSVej75DdQn',
    language: 'fr_FR',
    version: 2
  },

  // Build Configuration (https://go.nuxtjs.dev/config-build)
  build: {
    extractCSS: {
      ignoreOrder: true
    },
    babel: {
      compact: true,
      minified: true
    }
  },

  generate: {
    fallback: true
  },

  loading: {
    color: 'white'
  },

  generateContent: {
    srcDir: 'latex/',
    destDir: 'content/markdown/',
    pdfDir: 'static/pdf/',
    pandocRedefinitions: 'latex/pandoc.tex',
    ignored: ['latex/common.tex'],
    imagesDir: 'latex/images',
    imagesDestDir: 'static/img/'
  }
}
