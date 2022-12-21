<template>
  <div class="h2-ad-container">
    <client-only>
      <ad-by-google />
    </client-only>
    <h2 :id="id">
      <span class="toc-content">
        <slot />
      </span>
      <title-anchor v-if="id" class="anchor" :anchor="id" />
    </h2>
  </div>
</template>

<script>
import TitleAnchor from '~/components/Lesson/TitleAnchor'
import AdByGoogle from '~/components/Lesson/AdByGoogle'

export default {
  components: { TitleAnchor, AdByGoogle },
  props: {
    id: {
      type: String,
      default: null
    }
  }
}
</script>

<style lang="scss" scoped>
.h2-ad-container {
  counter-reset: headline-3;

  h2 {
    font-size: 2.4rem;
    color: #23618a;
    padding-bottom: 0.5rem;
    margin-top: 2.4rem;
    margin-bottom: 1.4rem;
    border-bottom: 1px solid rgba(black, 0.1);
    text-align: left;
    counter-increment: headline-2;

    &:hover .anchor {
      margin-left: 0.2em;
      opacity: 1;
    }

    &:before {
      content: counter(headline-2, upper-roman) ' – '
    }

    &:first-of-type {
      margin-top: 0;
    }
  }
}
</style>
