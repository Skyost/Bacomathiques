<template>
  <div class="formula">
    <slot />
  </div>
</template>

<script>
export default {
  name: 'FormulaBubble'
}
</script>

<style lang="scss">
@import "assets/bubble";
@import "assets/colors";

.formula {
  @include bubble('À connaître 💡', $main-color, #ebf3fb);
}
</style>
