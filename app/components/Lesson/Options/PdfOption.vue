<script setup lang="ts">
import LessonHeaderOption from '~/components/Lesson/Options/LessonHeaderOption.vue'
import type { Lesson } from '~/types'

defineProps<{ lesson: Lesson }>()
</script>

<template>
  <a
    :href="lesson.pdf"
    target="_blank"
  >
    <lesson-header-option
      id="pdf"
      title="Télécharger le PDF"
    />
  </a>
</template>
