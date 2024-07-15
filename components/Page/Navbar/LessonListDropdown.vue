<script setup lang="ts">
import LessonList from '~/components/Page/Navbar/LessonList.vue'
</script>

<template>
  <b-nav-item-dropdown auto-close="outside">
    <template #button-content>
      <icon name="bi:tag-fill" /> Accès direct à un cours
    </template>
    <lesson-list />
  </b-nav-item-dropdown>
</template>
