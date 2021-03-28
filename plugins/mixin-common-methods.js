import Vue from 'vue'

Vue.mixin({
  methods: {
    buildBrowserTitle (content) {
      return `${content} | ${this.$store.state.siteName}`
    },
    buildBrowserLessonTitle (level, lesson, isSummary) {
      let result = `${this.level.name} > ${this.lesson.title}`
      if (isSummary) {
        result += ' > Fiche résumée'
      }
      return this.buildBrowserTitle(result)
    },
    sleeper (ms) {
      return new Promise(resolve => setTimeout(resolve, ms))
    },
    renderMathJax () {
      window.MathJax = {
        tex: {
          inlineMath: [['$', '$']]
        },
        options: {
          renderActions: {
            addMenu: [0, '', '']
          }
        }
      }

      const polyfill = document.createElement('script')
      polyfill.src = 'https://polyfill.io/v3/polyfill.min.js?features=es6'
      document.head.appendChild(polyfill)

      const mathjax = document.createElement('script')
      mathjax.src = 'https://cdn.jsdelivr.net/npm/mathjax@3.1.2/es5/tex-chtml.js'
      mathjax.async = true
      document.head.appendChild(mathjax)
    },
    getCurrentAddress () {
      return `https://bacomathiqu.es${this.$route.path}`
    },
    getAvatarURL (author) {
      const username = author == null || author.length === 0 ? 'Anonyme' : author
      if (username === 'Skyost') {
        return 'https://www.skyost.eu/assets/img/skyost.png'
      }
      return `https://avatars.dicebear.com/api/bottts/${username}.svg`
    }
  }
})

Vue.config.ignoredElements = [
  /^mjx-/
]
