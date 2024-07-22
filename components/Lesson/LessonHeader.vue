<script setup lang="ts">
import type { Lesson } from '~/types'

withDefaults(defineProps<{
  lesson: Lesson
  isSummary?: boolean
}>(), {
  isSummary: false
})

const headerImage = ref<HTMLSpanElement | null>(null)

onBeforeMount(() => window.addEventListener('resize', adjustPreviewHeight))
onBeforeUnmount(() => window.removeEventListener('resize', adjustPreviewHeight))
onMounted(async () => {
  await nextTick()
  adjustPreviewHeight()
})

const adjustPreviewHeight = () => {
  if (headerImage.value) {
    headerImage.value.style.height = `${headerImage.value.offsetWidth}px`
  }
}
</script>

<template>
  <image-header
    ref="root"
    :image="lesson.preview"
  >
    <template #image>
      <span
        ref="headerImage"
        class="header-image ms-auto me-auto ms-md-0 me-md-0"
        :style="`background-image: url('${lesson.preview}');`"
      />
    </template>
    <lesson-header-content
      :lesson="lesson"
      :is-summary="isSummary"
    />
  </image-header>
</template>

<style lang="scss" scoped>
@import 'assets/colors';
@import 'assets/bootstrap-mixins';

.header-image {
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
    background-color: $primary;
  }

  @include media-breakpoint-down(md) {
    max-width: 150px;
    border: 4px solid white;
  }
}
</style>
