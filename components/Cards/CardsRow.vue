<template>
  <b-container class="flat-cards" fluid="">
    <b-row class="justify-content-center" :data-sal="sal">
      <slot />
    </b-row>
  </b-container>
</template>

<script>
export default {
  name: 'CardsRow',
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
  background: linear-gradient(180deg, $main-color 90px, transparent 90px);

  .flat-card-content {
    height: 100%;
  }
}
</style>
