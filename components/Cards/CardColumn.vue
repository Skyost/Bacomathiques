<template>
  <ski-column :class="`mb-xl-${mb}`" width="12" :lg="(size + 1).toString()" :xl="size.toString()">
    <nuxt-link class="link" :to="to">
      <flat-card :image="image" class="h-100" :blue="blue">
        <slot />
      </flat-card>
    </nuxt-link>
  </ski-column>
</template>

<script>
import FlatCard from '~/components/Cards/FlatCard'

export default {
  components: { FlatCard },
  props: {
    to: {
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
      default: null
    }
  }
}
</script>

<style lang="scss" scoped>
.link {
  display: block;
  height: 100%;
  text-decoration: none !important;
}
</style>
