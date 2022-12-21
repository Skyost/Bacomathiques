<template>
  <h3 :id="id">
    <span class="toc-content">
      <slot />
    </span>
    <title-anchor v-if="id" class="anchor" :anchor="id" />
  </h3>
</template>

<script>
import TitleAnchor from '~/components/Lesson/TitleAnchor'

export default {
  components: { TitleAnchor },
  props: {
    id: {
      type: String,
      default: null
    }
  }
}
</script>

<style lang="scss" scoped>
@import 'assets/colors';

h3 {
  color: $primary;
  margin-bottom: 1rem;
  text-align: left;
  counter-increment: headline-3;

  &:hover .anchor {
    margin-left: 0.2em;
    opacity: 1;
  }

  &:before {
    content: counter(headline-3) '. '
  }
}
</style>
