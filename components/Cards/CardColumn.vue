<script setup lang="ts">
import FlatCard from '~/components/Cards/FlatCard'

withDefaults(defineProps<{
  to?: string
  blue?: boolean
  size: number
  mb?: number
  image?: string
}>(), {
  to: undefined,
  blue: false,
  mb: 0,
  image: undefined
})
</script>

<template>
  <b-col
    :class="`mb-xl-${mb}`"
    width="12"
    :lg="size + 1"
    :xl="size"
  >
    <nuxt-link
      class="link"
      :to="to"
    >
      <flat-card
        :image="image"
        class="h-100"
        :blue="blue"
      >
        <slot />
      </flat-card>
    </nuxt-link>
  </b-col>
</template>

<style lang="scss" scoped>
.link {
  display: block;
  height: 100%;
  text-decoration: none !important;
}
</style>
