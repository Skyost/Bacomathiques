<script setup lang="ts">
import LessonList from '~/components/Page/Navbar/LessonList.vue'
</script>

<template>
  <li class="nav-item dropdown">
    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
      <ski-icon icon="tag-fill" /> Accès direct à un cours
    </a>
    <div class="dropdown-menu dropdown-menu-end p-0">
      <lesson-list />
    </div>
  </li>
</template>
