<script setup lang="ts">
import LessonList from '~/components/Page/Navbar/LessonList.vue'
</script>

<template>
  <client-only>
    <b-nav-item-dropdown
      v-b-color-mode="'light'"
      auto-close="outside"
      class="page-navbar-item"
    >
      <template #button-content>
        <icon name="bi:tag-fill" /> Accès direct à un cours
      </template>
      <lesson-list />
    </b-nav-item-dropdown>
  </client-only>
</template>

<style lang="scss" scoped>
:deep(.btn-link) {
  color: var(--bs-nav-link-color);

  &:hover {
    color: var(--bs-nav-link-hover-color);
  }

  &:active {
    color: var(--bs-nav-link-hover-color);
  }
}
</style>
