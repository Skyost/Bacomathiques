export default {
  // Target (https://go.nuxtjs.dev/config-target)
  target: 'static',

  // Global page headers (https://go.nuxtjs.dev/config-head)
  head: {
    htmlAttrs: {
      lang: 'fr'
    },
    title: 'Bacomathiques',
    meta: [
      { charset: 'utf-8' },
      { hid: 'description', name: 'description', content: 'Bacomathiques est un petit site web qui contient tout ce dont vous avez besoin pour réviser vos maths en toute tranquillité de la Première à la Terminale ! Que vous cherchiez à passer votre Baccalauréat ou que vous souhaitiez simplement réviser votre cours ; tout est possible et tout est gratuit. Au programme : cours de mathématiques gratuits, téléchargeables et imprimables, annales et corrigés des sujets précédents, etc.' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { name: 'theme-color', content: '#2489cc' }
    ],
    link: [
      { rel: 'stylesheet', href: 'https://cdn.jsdelivr.net/npm/futura-font@1.0.0/styles.min.css' },
      { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css2?family=Handlee&display=swap' },
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
      remarkPlugins: [
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
        fontURL: 'https://cdn.jsdelivr.net/npm/mathjax@3.1.2/es5/output/chtml/fonts/woff-v2'
      }
    },
    nestedProperties: [
      'lessons.lesson',
      'lessons.level'
    ]
  },

  robots: {
    UserAgent: '*',
    Disallow: ['/api/', '/_nuxt/'],
    Sitemap: 'https://bacomathiqu.es/sitemap.xml'
  },

  sitemap: {
    hostname: 'https://bacomathiqu.es',
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
  }
}
