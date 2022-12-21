<template>
  <ski-modal
    id="modal-lesson-list"
    title="Accès direct à un cours"
    close-button="Fermer"
    size="lg"
  >
    <lesson-list @lessonpicked="closeModal" />
  </ski-modal>
</template>

<script>
import LessonList from '~/components/Navbar/LessonList/LessonList'

export default {
  components: { LessonList },
  methods: {
    closeModal () {
      new bootstrap.Modal(`#${this.$el.id}`).hide()
    }
  }
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
