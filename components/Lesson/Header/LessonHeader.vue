<template>
  <image-header :image="lesson.preview" background>
    <lesson-header-content :level="level" :lesson="lesson" :is-summary="isSummary" />
  </image-header>
</template>

<script>
import ImageHeader from '../../ImageHeader'
import LessonHeaderContent from './LessonHeaderContent'

export default {
  name: 'LessonHeader',
  components: { ImageHeader, LessonHeaderContent },
  props: {
    level: {
      type: Object,
      required: true
    },
    lesson: {
      type: Object,
      required: true
    },
    isSummary: {
      type: Boolean,
      defaultValue: false
    }
  },
  beforeMount () {
    window.addEventListener('resize', this.adjustPreviewHeight)
  },
  beforeDestroy () {
    window.removeEventListener('resize', this.adjustPreviewHeight)
  },
  async mounted () {
    await this.$nextTick()
    this.adjustPreviewHeight()
  },
  methods: {
    adjustPreviewHeight () {
      const preview = this.$el.querySelector('.header-image')
      // noinspection JSSuspiciousNameCombination
      preview.style.height = `${preview.offsetWidth}px`
    }
  }
}
</script>

<style lang="scss" scoped>
@import "assets/colors";
@import "assets/breakpoints";

::v-deep .header-image {
  position: relative;
  display: block;
  border-radius: 100%;
  max-width: 300px;
  width: 100%;
  border: 8px solid white;
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;

  &::after {
    position: absolute;
    content: '';
    display: block;
    border-radius: 100%;
    height: 100%;
    width: 100%;
    opacity: 0.5;
    background-color: $main-color;
  }

  @media (max-width: $mobile-width) {
    max-width: 150px;
    border: 4px solid white;
  }
}
</style>
