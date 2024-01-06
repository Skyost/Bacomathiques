import sal from 'sal.js'

export const useSal = () => {
  onMounted(async () => {
    import('sal.js/dist/sal.css')
    // @ts-ignore
    sal({ threshold: window.outerWidth <= 768 ? 0.1 : 0.25 })
    await nextTick()
    const handled: HTMLElement[] = []
    const salElements = document.querySelectorAll('[data-sal]')
    for (const salElement of salElements) {
      const parent = salElement.parentElement
      if (!parent || handled.includes(parent)) {
        continue
      }
      const previousOverflowX = parent.style.overflowX
      parent.style.overflowX = 'hidden'
      parent.addEventListener('sal:in', () => {
        parent.style.overflowX = previousOverflowX
      })
      handled.push(parent)
    }
  })
}
