<template>
  <img
    class="option"
    :src="`/img/lessons/${id}.svg`"
    :alt="title"
    :title="title"
  >
</template>

<script>
export default {
  name: 'LessonHeaderOption',
  props: {
    id: {
      type: String,
      required: true
    },
    title: {
      type: String,
      required: true
    }
  }
}
</script>

<style lang="scss">
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
