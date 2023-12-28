<script setup lang="ts">
import LessonList from '~/components/Page/Navbar/LessonList.vue'
</script>

<template>
  <ski-modal
    id="modal-lesson-list"
    title="Accès direct à un cours"
    close-button="Fermer"
    size="lg"
  >
    <lesson-list />
  </ski-modal>
</template>

<style lang="scss" scoped>
#modal-lesson-list ul {
  margin-bottom: 0;
  padding-top: 14px;

  li {
    padding: 6px 0;
    white-space: normal;
  }

  &.dropdown-header {
    text-transform: uppercase;
  }
}
</style>
