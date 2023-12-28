<script setup lang="ts">
defineProps<{ id: string, title: string }>()
</script>

<template>
  <img
    class="option"
    :src="`/img/lessons/${id}.svg`"
    :alt="title"
    :title="title"
  >
</template>

<style lang="scss" scoped>
.option {
  cursor: pointer;
  height: 40px;
  margin: 0 0.5em;
  position: relative;
  opacity: 0.8;
  transition: opacity 200ms;

  &:hover {
    opacity: 1;
  }
}
</style>
