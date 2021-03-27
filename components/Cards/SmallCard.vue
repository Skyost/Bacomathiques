<template>
  <b-col :class="`flat-card mb-xl-${mb}`" cols="12" :lg="size + 1" :xl="size">
    <nuxt-link
      v-if="isInternalLink"
      class="flat-card-content h-100"
      :class="{'blue': blue}"
      :to="href"
    >
      <img class="flat-card-image" :src="image" :alt="image">
      <slot />
    </nuxt-link>
    <a
      v-else-if="href"
      class="flat-card-content h-100"
      :class="{'blue': blue}"
      :href="href"
    >
      <img class="flat-card-image" :src="image" :alt="image">
      <slot />
    </a>
    <div
      v-else
      class="flat-card-content h-100"
      :class="{'blue': blue}"
    >
      <img class="flat-card-image" :src="image" :alt="image">
      <slot />
    </div>
  </b-col>
</template>

<script>
export default {
  name: 'SmallCard',
  props: {
    href: {
      type: String,
      default: null
    },
    blue: {
      type: Boolean,
      default: false
    },
    size: {
      type: Number,
      required: true
    },
    mb: {
      type: Number,
      default: 0
    },
    image: {
      type: String,
      required: true
    }
  },
  computed: {
    isInternalLink () {
      return this.href ? this.href.startsWith('/') : false
    }
  }
}
</script>

<style lang="scss">
@import 'assets/common';
@import 'assets/flat_card';
</style>
