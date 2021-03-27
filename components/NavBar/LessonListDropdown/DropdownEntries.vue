<template>
  <li>
    <span v-if="lessonsToShow.length > 0" class="dropdown-header">
      <b-icon-pen-fill /> Cours de {{ level.name }}
    </span>
    <nuxt-link
      v-for="lesson in lessonsToShow"
      :key="lesson.id"
      class="dropdown-item"
      :class="{'current': (getLessonURL(level, lesson) === $route.path || getLessonURL(level, lesson) === ($route.path + '/'))}"
      :to="getLessonURL(level, lesson)"
      @click.native="clickCallback(level, lesson)"
      v-text="lesson.title"
    />
  </li>
</template>

<script>
import { BIconPenFill } from 'bootstrap-vue'

export default {
  name: 'DropdownEntries',
  components: { BIconPenFill },
  props: {
    level: {
      type: Object,
      required: true
    },
    searchTerms: {
      type: String,
      default: null
    },
    clickCallback: {
      type: Function,
      default: () => {}
    }
  },
  data () {
    return {
      lessons: []
    }
  },
  async fetch () {
    const lessons = await this.$content('lessons', this.level.id).sortBy('chapter').fetch()
    for (const lesson of lessons) {
      lesson.searchTerms = this.normalize(`${lesson.title} (${this.level.name})`)
    }
    this.lessons = lessons
  },
  computed: {
    lessonsToShow () {
      return this.lessons.filter(lesson => lesson.searchTerms.includes(this.searchTerms ?? ''))
    }
  },
  methods: {
    getLessonURL (level, lesson) {
      return `/cours/${level.id}/${lesson.id}/`
    },
    normalize (string) {
      return string.normalize('NFD').replace(/[\u0300-\u036F]/g, '').toLowerCase()
    }
  }
}
</script>

<style lang="scss">
@import 'assets/colors';

.dropdown-item.current {
  color: darken($main-color, 10%);
}
</style>
