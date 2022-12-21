<template>
  <h4 :id="id">
    <slot />
  </h4>
</template>

<script>
export default {
  props: {
    id: {
      type: String,
      default: null
    }
  }
}
</script>

<style lang="scss" scoped>
h4 {
  text-align: left;
}
</style>
