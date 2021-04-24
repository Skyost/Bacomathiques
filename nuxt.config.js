import { MATHJAX_VERSION } from './utils/math'
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
    markdown: {
      remarkPlugins: () => [
        'remark-squeeze-paragraphs',
        '~/plugins/remark-slug',
        'remark-autolink-headings',
        'remark-external-links',
        'remark-footnotes',
        '~/plugins/remark-numberize.js',
        'remark-math',
        'remark-gfm'
      ],
      rehypePlugins: [
        'rehype-mathjax/chtml'
      ],
      remarkAutolinkHeadings: {
        behavior: 'append',
        content: {
          type: 'element',
          tagName: 'span',
          properties: { className: ['anchor'] }
        }
      },
      rehypeMathjaxChtml: {
        fontURL: `https://cdn.jsdelivr.net/npm/mathjax@${MATHJAX_VERSION}/es5/output/chtml/fonts/woff-v2`
      }
    },
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

  vue: {
    config: {
      ignoredElements: [/^mjx-/]
    }
  },

  generate: {
    fallback: true
  },

  loading: {
    color: 'white'
  }
}
