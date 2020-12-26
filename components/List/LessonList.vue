<template>
  <cards-row>
    <lesson-card v-for="lesson in lessons" :key="lesson.id" :lesson="lesson" />
  </cards-row>
</template>

<script>
import CardsRow from '../Cards/CardsRow'
import LessonCard from '../Cards/LessonCard'
export default {
  name: 'LessonList',
  components: { CardsRow, LessonCard },
  props: {
    level: {
      type: Object,
      default: null
    }
  },
  data () {
    return {
      lessons: []
    }
  },
  async fetch () {
    this.lessons = await this.$content('lessons', this.level.id).sortBy('chapter').fetch()
  }
}
</script>
