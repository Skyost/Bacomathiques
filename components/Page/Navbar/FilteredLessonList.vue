<script setup lang="ts">
import type { Lesson, Level, LevelId } from '~/types'
import { levels, prependChapterToTitle } from '~/site/site'

const props = withDefaults(defineProps<{
  levelId: LevelId,
  lessons: Lesson[],
  filter?: string
}>(), {
  filter: undefined
})

const route = useRoute()

const getLessonUrl = (lesson: Lesson) => `/cours/${lesson.level}/${lesson.id}/`
const currentClass = (lesson: Lesson) => {
  const lessonUrl = getLessonUrl(lesson)
  return (lessonUrl === route.path || lessonUrl === (route.path + '/')) ? 'current' : null
}

const level = computed<Level>(() => levels[props.levelId])
const filteredLessons = computed<Lesson[]>(() => props.lessons.filter(lesson => lesson.level === props.levelId && lesson['title-search'].includes(props.filter ?? '')))

const root = ref<HTMLElement | null>(null)

onMounted(async () => {
  await nextTick()
  root.value!.style.minWidth = `${root.value!.offsetWidth}px`
})
</script>

<template>
  <ul v-if="filteredLessons.length > 0" ref="root" class="lesson-list list-group">
    <li class="dropdown-header">
      <ski-icon icon="pen-fill" /> Cours de {{ level.name }}
    </li>
    <li
      v-for="lesson in filteredLessons"
      :key="lesson.id"
    >
      <nuxt-link
        class="dropdown-item"
        :class="currentClass(lesson)"
        :to="getLessonUrl(lesson)"
      >
        {{ prependChapterToTitle(lesson) }}
      </nuxt-link>
    </li>
  </ul>
</template>

<style lang="scss" scoped>
@import 'assets/colors';

.lesson-list {
  list-style-type: none;
  padding-left: 0;

  .current {
    color: $primary;
  }
}
</style>
