<template>
  <ul class="lesson-list">
    <li
      v-if="filteredLessons.length > 0"
      class="dropdown-header"
    >
      <ski-icon icon="pen-fill" /> Cours de {{ levelName }}
    </li>
    <li
      v-for="lesson in filteredLessons"
      :key="lesson.id"
    >
      <nuxt-link
        class="dropdown-item"
        :class="{'current': (getLessonUrl(lesson) === $route.path || getLessonUrl(lesson) === ($route.path + '/'))}"
        :to="getLessonUrl(lesson)"
        @click="$emit('lessonpicked', { level, lesson })"
      >
        {{ prependChapterToTitle(lesson) }}
      </nuxt-link>
    </li>
  </ul>
</template>

<script>
import { prependChapterToTitle, levels } from '~/utils/lesson'

export default {
  name: 'FilteredLessonList',
  props: {
    level: {
      type: String,
      required: true
    },
    lessons: {
      type: Array,
      required: true
    },
    filter: {
      type: String,
      default: null
    }
  },
  emits: ['lessonpicked'],
  computed: {
    levelName () {
      return levels[this.level].name
    },
    filteredLessons () {
      return this.lessons.filter(lesson => lesson.level === this.level && lesson.searchTerms.includes(this.filter ?? ''))
    }
  },
  methods: {
    prependChapterToTitle (lesson) {
      return prependChapterToTitle(lesson)
    },
    getLessonUrl (lesson) {
      return `/cours/${lesson.level}/${lesson.id}/`
    }
  }
}
</script>

<style lang="scss" scoped>
.lesson-list {
  list-style-type: none;
  padding-left: 0;
}
</style>
