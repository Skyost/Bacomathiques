const MATHJAX_VERSION = '3.2.0'

function renderMathJax () {
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
  mathjax.src = `https://cdn.jsdelivr.net/npm/mathjax@${MATHJAX_VERSION}/es5/tex-chtml.js`
  mathjax.async = true
  document.head.appendChild(mathjax)
}

module.exports = { renderMathJax, MATHJAX_VERSION }
