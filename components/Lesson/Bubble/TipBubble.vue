<template>
  <div class="tip">
    <slot />
  </div>
</template>

<script>
export default {
  name: 'TipBubble'
}
</script>

<style lang="scss">
@import "assets/bubble";

.tip {
  $border-color: #26a65b;

  @include bubble('À lire 👀', $border-color, #dcf3d8);

  a {
    color: darken($border-color, 10%) !important;
    text-decoration-color: lighten($border-color, 5%) !important;

    &:hover,
    &:active {
      color: darken($border-color, 20%) !important;
      text-decoration-color: darken($border-color, 5%) !important;
    }
  }
}
</style>
