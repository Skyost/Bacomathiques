<script setup lang="ts">
withDefaults(defineProps<{
  sal?: string
}>(), {
  sal: undefined
})
</script>

<template>
  <b-container
    class="flat-cards"
    :fluid="true"
  >
    <b-row
      class="justify-content-center"
      :data-sal="sal"
    >
      <slot />
    </b-row>
  </b-container>
</template>

<style lang="scss" scoped>
@import 'assets/colors';

.flat-cards {
  background: linear-gradient(180deg, $primary 90px, transparent 90px);

  .flat-card-content {
    height: 100%;
  }
}
</style>
