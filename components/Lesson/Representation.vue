<template>
  <div :id="geogebraId" class="ml-auto mr-auto mb-3 mw-100" />
</template>

<script>
export default {
  name: 'Representation',
  props: {
    geogebraId: {
      type: String,
      required: true
    }
  },
  head () {
    return {
      script: [
        {
          hid: 'geogebra',
          src: 'https://www.geogebra.org/apps/deployggb.js',
          async: true
        }
      ]
    }
  },
  mounted () {
    if (document.readyState === 'complete') {
      this.createGeoGebraInstance(this.geogebraId)
    } else {
      window.onload = this.makeDoubleDelegate(window.onload, () => this.createGeoGebraInstance(this.geogebraId))
    }
  },
  destroyed () {
    if (window[this.geogebraId]) {
      window[this.geogebraId].remove()
      window.onresize = null
    }
  },
  methods: {
    createGeoGebraInstance (materialId) {
      const parent = this.$el.parentElement
      const availableWidth = parent.getBoundingClientRect().width - parent.style.paddingLeft - parent.style.paddingRight
      const width = Math.min(availableWidth, 800)

      const windowWidth = window.innerWidth
      let scale = 1
      if (windowWidth < 992) {
        scale = 2
      }
      if (windowWidth < 768) {
        scale = 4
      }

      // eslint-disable-next-line no-undef
      new window.GGBApplet({
        id: materialId,
        material_id: materialId,
        height: 0.75 * width,
        width,
        showResetIcon: true,
        enableLabelDrags: false,
        scale,
        allowUpscale: true,
        scaleContainerClass: 'plot',
        // 'showZoomButtons': true,
        preventFocus: true,
        enableShiftDragZoom: true,
        borderColor: 'rgba(0, 0, 0, 0.5)'
      }, true).inject(this.geogebraId)
    },
    makeDoubleDelegate (function1, function2) {
      return function () {
        if (function1) {
          function1()
        }
        if (function2) {
          function2()
        }
      }
    }
  }
}
</script>
