import sal from 'sal.js'

export const useSal = () => {
  onMounted(() => {
    import('sal.js/dist/sal.css')
    // @ts-ignore
    sal({ threshold: window.outerWidth <= 768 ? 0.1 : 0.25 })
  })
}
