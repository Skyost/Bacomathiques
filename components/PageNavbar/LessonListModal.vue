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

<script>
import LessonList from '~/components/PageNavbar/LessonList.vue'

export default {
  components: { LessonList }
}
</script>

<style lang="scss">
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
