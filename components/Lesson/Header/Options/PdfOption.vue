<template>
  <lesson-header-option
    id="pdf"
    title="Télécharger le PDF"
    @click.native="onClick"
  />
</template>

<script>
import LessonHeaderOption from './LessonHeaderOption'

export default {
  name: 'PdfOption',
  components: { LessonHeaderOption },
  props: {
    lesson: {
      type: Object,
      required: true
    }
  },
  methods: {
    onClick () {
      window.open(this.lesson.pdf, '_blank')
    }
  }
}
</script>
