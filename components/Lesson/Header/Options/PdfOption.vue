<template>
  <a :href="pdfUrl" target="_blank">
    <lesson-header-option
      id="pdf"
      title="Télécharger le PDF"
    />
  </a>
</template>

<script>
import LessonHeaderOption from '~/components/Lesson/Header/Options/LessonHeaderOption'
import { getPdfUrl } from '~/utils/lesson'

export default {
  components: { LessonHeaderOption },
  props: {
    lesson: {
      type: Object,
      required: true
    }
  },
  computed: {
    pdfUrl () {
      return getPdfUrl(this.lesson)
    }
  }
}
</script>
