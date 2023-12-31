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
@import 'assets/colors';

#modal-lesson-list {
  :deep(ul) {
    margin-bottom: 0;
    padding-top: 14px;
  }

  :deep(li) {
    max-width: 100%;

    &.dropdown-header {
      color: rgba(black, 0.6);
    }

    a {
      padding: 10px 4px;
      transition: all 200ms;
      text-overflow: ellipsis;
      white-space: nowrap;
      overflow: hidden;

      &:active {
        color: white;
        background-color: $primary;
      }
    }
  }
}
</style>
