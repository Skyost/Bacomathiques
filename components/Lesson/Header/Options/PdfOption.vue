<template>
  <a :href="lesson.pdf" target="_blank">
    <lesson-header-option
      id="pdf"
      title="Télécharger le PDF"
    />
  </a>
</template>

<script>
import LessonHeaderOption from '~/components/Lesson/Header/Options/LessonHeaderOption'

export default {
  components: { LessonHeaderOption },
  props: {
    lesson: {
      type: Object,
      required: true
    }
  }
}
</script>
