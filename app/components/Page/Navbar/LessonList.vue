<script setup lang="ts">
import FilteredLessonList from '~/components/Page/Navbar/FilteredLessonList.vue'
import { levels } from '~/site/site'
import type { Lesson, LevelId } from '~/types'

const searchTerms = ref<string | undefined>()
const levelIdList = Object.keys(levels) as LevelId[]

const { pending, data } = useLazyAsyncData(
  'lesson-list',
  () => queryCollection('lessons')
    .order('chapter', 'ASC')
    .all()
)
</script>

<template>
  <div class="list">
    <em v-if="pending">Chargement de la liste des cours...</em>
    <div v-else-if="data">
      <b-form
        action="/recherche/"
        method="get"
      >
        <b-form-input
          id="lesson-list-search"
          v-model="searchTerms"
          class="border-0"
          type="search"
          name="requete"
          placeholder="Chercher un cours..."
        />
      </b-form>
      <filtered-lesson-list
        v-for="levelId in levelIdList"
        :key="levelId"
        :level-id="levelId"
        :lessons="data as Lesson[]"
        :filter="searchTerms"
      />
    </div>
    <div v-else>
      <em>Pas de cours à afficher.</em>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.list {
  max-height: calc(100vh - 130px);
  overflow: auto;
  padding: 0;
}
</style>
