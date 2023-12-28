<script setup lang="ts">
withDefaults(defineProps<{
  sal?: string
}>(), {
  sal: undefined
})
</script>

<template>
  <ski-container class="flat-cards" :fluid="true">
    <ski-columns class="justify-content-center" :data-sal="sal">
      <slot />
    </ski-columns>
  </ski-container>
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
