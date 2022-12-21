<script setup>
import { useHead } from 'nuxt/app'

useHead({
  script: [
    { src: 'https://www.geogebra.org/apps/deployggb.js' }
  ]
})
</script>

<template>
  <div :id="geogebraId" class="ms-auto me-auto mb-3 mw-100" />
</template>

<script>
export default {
  props: {
    geogebraId: {
      type: String,
      required: true
    }
  },
  async mounted () {
    await this.$nextTick()
    this.createGeoGebraInstanceWhenPossible()
  },
  unmounted () {
    if (window[this.geogebraId] && window[this.geogebraId].remove) {
      window[this.geogebraId].remove()
      window.onresize = null
    }
  },
  methods: {
    createGeoGebraInstanceWhenPossible () {
      if (window.GGBApplet) {
        this.createGeoGebraInstance()
        return
      }

      setTimeout(this.createGeoGebraInstanceWhenPossible, 500)
    },
    createGeoGebraInstance () {
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

      new window.GGBApplet({
        id: this.geogebraId,
        material_id: this.geogebraId,
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
    }
  }
}
</script>
