<script setup>
import { useLazyAsyncData } from 'nuxt/app'
import { computed } from 'vue'
import { normalize } from '~/utils/utils'
import { levels } from '~/utils/lesson'

const levelsList = computed(() => Object.values(levels))

const { pending, data } = useLazyAsyncData(
  async () => {
    const lessons = await queryContent('generated', 'lessons')
      // .sort({ chapter: 1 })
      .find()
    for (const lesson of lessons) {
      lesson.searchTerms = normalize(`${lesson.title} (${levels[lesson.level].name})`)
    }
    return lessons
      .sort((a, b) => parseInt(a.chapter) - parseInt(b.chapter))
  }
)
</script>

<template>
  <div>
    <em v-if="pending">Chargement de la liste des cours...</em>
    <div v-else>
      <form action="/recherche/" method="get">
        <input
          v-model="searchTerms"
          class="form-control"
          type="search"
          name="requete"
          placeholder="Chercher un cours..."
        >
      </form>
      <filtered-lesson-list
        v-for="level in levelsList"
        :key="level.id"
        :level="level.id"
        :lessons="data"
        :filter="searchTerms"
      />
    </div>
  </div>
</template>

<script>
import FilteredLessonList from '~/components/PageNavbar/FilteredLessonList.vue'

export default {
  components: { FilteredLessonList },
  data () {
    return {
      searchTerms: null
    }
  }
}
</script>
