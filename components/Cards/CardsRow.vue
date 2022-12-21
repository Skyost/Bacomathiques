<template>
  <ski-container class="flat-cards" :fluid="true">
    <ski-columns class="justify-content-center" :data-sal="sal">
      <slot />
    </ski-columns>
  </ski-container>
</template>

<script>
export default {
  props: {
    sal: {
      type: String,
      default: null
    }
  }
}
</script>

<style lang="scss">
@import 'assets/colors';

.flat-cards {
  background: linear-gradient(180deg, $primary 90px, transparent 90px);

  .flat-card-content {
    height: 100%;
  }
}
</style>
