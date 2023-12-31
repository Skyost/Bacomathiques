<script setup lang="ts">
import FilteredLessonList from '~/components/Page/Navbar/FilteredLessonList.vue'
import { levels } from '~/site/site'
import type { Lesson, LevelId } from '~/types'
import { siteContentSettings } from '~/site/content'

const searchTerms = ref<string | undefined>()
const levelIdList = Object.keys(levels) as LevelId[]

const { pending, data } = useLazyAsyncData(
  'lesson-list',
  () => queryContent<Lesson>(siteContentSettings.dataLatexDirectory)
    .without(['body', 'summary', 'toc'])
    .sort({ chapter: 1, $numeric: true })
    .find()
)
</script>

<template>
  <div class="list">
    <em v-if="pending">Chargement de la liste des cours...</em>
    <div v-else-if="data">
      <form action="/recherche/" method="get">
        <ski-form-control
          v-model="searchTerms"
          class="border-0"
          type="search"
          name="requete"
          placeholder="Chercher un cours..."
        />
      </form>
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
