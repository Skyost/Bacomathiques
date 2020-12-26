<template>
  <div class="proof">
    <slot />
  </div>
</template>

<script>
export default {
  name: 'ProofBubble'
}
</script>

<style lang="scss">
@import "assets/bubble";

.proof {
  @include bubble('Démonstration 🧠', #f1c40f, #fff8de);
}
</style>
