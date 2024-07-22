<script setup lang="ts">
import type { Ref } from 'vue'
import katex from 'katex'
import PageLoading from '~/components/Page/PageLoading.vue'
import PageHeader from '~/components/Page/PageHeader.vue'
import PageContent from '~/components/Page/PageContent.vue'
import PageHead from '~/components/Page/PageHead.vue'
import LessonCard from '~/components/Cards/LessonCard.vue'
import BigCard from '~/components/Cards/BigCard.vue'
import type { Lesson } from '~/types'

const route = useRoute()
const request = computed<string | undefined>(() => route.query.requete?.toString())
const regexPattern = computed<string>(() => request.value ? normalizeString(request.value.toString()) : '.*')

const { error, pending, data } = useLazyAsyncData(
  route.path,
  // TODO: Follow this issue : https://github.com/nuxt/content/issues/1758 for implementing a "true" search page.
  () => queryContent<Lesson>('latex', 'lessons')
    .without(['body', 'summary', 'toc'])
    .sort({ chapter: 1, $numeric: true })
    .find()
)

const doSearch = (list: Ref<Omit<Lesson, string>[] | null>): Lesson[] => {
  const result: Lesson[] = []
  if (!list.value) {
    return result
  }
  for (const value of list.value) {
    const regex = RegExp(regexPattern.value, 'ig')
    const lesson = value as Lesson
    if (regex.test(lesson['title-search'])) {
      result.push(lesson)
    }
  }
  return result
}

const calculus = computed<string>(() => {
  return katex.renderToString(`\\begin{align*}
  \\&frac{1}{3} = 0,3333\\times \\\\
  &\\iff 3 \\times frac{1}{3} &= 0,9999\\times \\\\
  &\\iff 1 &= 0,9999\\times
\\end{align*}`, { displayMode: true })
})

const lessons = computed<Lesson[]>(() => doSearch(data))
</script>

<template>
  <div>
    <page-head title="Résultat de la recherche" />

    <page-header>
      <image-header image="/img/search.svg">
        <h3>Résultat de la recherche</h3>
        <p class="mb-0">
          Votre recherche <q v-text="request && request.length > 0 ? request : 'Tout'" />
          a retourné <strong v-text="data ? lessons.length : 0" /> résultat(s).
        </p>
      </image-header>
    </page-header>

    <page-loading v-if="pending" />
    <page-content v-else-if="data">
      <cards-row v-if="lessons.length > 0">
        <lesson-card
          v-for="lesson in lessons"
          :key="`${lesson.level}-${lesson.id}`"
          class="col-lg-5 col-xl-4 col-12 mb-xl-5"
          :lesson="lesson"
          :show-level="true"
        />
      </cards-row>

      <cards-row
        v-else
        class="pb-5"
      >
        <big-card class="text-center">
          <p>
            Nous n'avons aucun résultat de recherche à vous afficher.
            À la place, voici un petit résultat mathématique qui peut sembler surprenant :
          </p>

          <span class="d-block mt-4 mb-4">
            <span v-html="calculus" />
          </span>

          <p class="mb-0">
            Cette identité est connue sous le nom de
            <a href="https://fr.wikipedia.org/wiki/D%C3%A9veloppement_d%C3%A9cimal_de_l%27unit%C3%A9">Développement décimal de l'unité</a>.
          </p>
        </big-card>
      </cards-row>
    </page-content>
    <page-error
      v-else
      :error="error"
    />
  </div>
</template>

<style lang="scss" scoped>
@import 'assets/bootstrap-mixins';

#page-header {
  padding-bottom: 70px;

  @include media-breakpoint-down(md) {
    padding-bottom: 40px;
  }
}

#page-content {
  padding-bottom: 0 !important;
}
</style>
