<script setup lang="ts">
import type { Ref } from 'vue'
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

      <cards-row v-else class="pb-5">
        <big-card class="text-center">
          <p>
            Nous n'avons aucun résultat de recherche à vous afficher.
            À la place, voici un petit résultat mathématique qui peut sembler surprenant :
          </p>

          <span class="d-block mt-4 mb-4">
            <span class="katex-display"><span class="katex"><span class="katex-html" aria-hidden="true"><span class="base"><span class="strut" style="height: 6.11488em; vertical-align: -2.80744em;" /><span class="mord"><span class="mtable"><span class="col-align-r"><span class="vlist-t vlist-t2"><span class="vlist-r"><span class="vlist" style="height: 3.30744em;"><span class="" style="top: -5.30744em;"><span class="pstrut" style="height: 3.32144em;" /><span class="mord" /></span><span class="" style="top: -3em;"><span class="pstrut" style="height: 3.32144em;" /><span class="mord"><span class="mspace" style="margin-right: 0.277778em;" /><span class="mrel">⟺</span><span class="mspace" style="margin-right: 0.277778em;" /></span></span><span class="" style="top: -1.174em;"><span class="pstrut" style="height: 3.32144em;" /><span class="mord"><span class="mspace" style="margin-right: 0.277778em;" /><span class="mrel">⟺</span><span class="mspace" style="margin-right: 0.277778em;" /></span></span></span><span class="vlist-s">&ZeroWidthSpace;</span></span><span class="vlist-r"><span class="vlist" style="height: 2.80744em;"><span class="" /></span></span></span></span><span class="col-align-l"><span class="vlist-t vlist-t2"><span class="vlist-r"><span class="vlist" style="height: 3.30744em;"><span class="" style="top: -5.30744em;"><span class="pstrut" style="height: 3.32144em;" /><span class="mord"><span class="mord" /><span class="mord"><span class="mopen nulldelimiter" /><span class="mfrac"><span class="vlist-t vlist-t2"><span class="vlist-r"><span class="vlist" style="height: 1.32144em;"><span class="" style="top: -2.314em;"><span class="pstrut" style="height: 3em;" /><span class="mord"><span class="mord">3</span></span></span><span class="" style="top: -3.23em;"><span class="pstrut" style="height: 3em;" /><span class="frac-line" style="border-bottom-width: 0.04em;" /></span><span class="" style="top: -3.677em;"><span class="pstrut" style="height: 3em;" /><span class="mord"><span class="mord">1</span></span></span></span><span class="vlist-s">&ZeroWidthSpace;</span></span><span class="vlist-r"><span class="vlist" style="height: 0.686em;"><span class="" /></span></span></span></span><span class="mclose nulldelimiter" /></span><span class="mspace" style="margin-right: 0.277778em;" /><span class="mrel">=</span><span class="mspace" style="margin-right: 0.277778em;" /><span class="mord">0</span><span class="mpunct">,</span><span class="mspace" style="margin-right: 0.166667em;" /><span class="mord">3333</span><span class="mspace" style="margin-right: 0.166667em;" /><span class="minner">…</span></span></span><span class="" style="top: -3em;"><span class="pstrut" style="height: 3.32144em;" /><span class="mord"><span class="mord" /><span class="mord">3</span><span class="mspace" style="margin-right: 0.222222em;" /><span class="mbin">×</span><span class="mspace" style="margin-right: 0.222222em;" /><span class="mord"><span class="mopen nulldelimiter" /><span class="mfrac"><span class="vlist-t vlist-t2"><span class="vlist-r"><span class="vlist" style="height: 1.32144em;"><span class="" style="top: -2.314em;"><span class="pstrut" style="height: 3em;" /><span class="mord"><span class="mord">3</span></span></span><span class="" style="top: -3.23em;"><span class="pstrut" style="height: 3em;" /><span class="frac-line" style="border-bottom-width: 0.04em;" /></span><span class="" style="top: -3.677em;"><span class="pstrut" style="height: 3em;" /><span class="mord"><span class="mord">1</span></span></span></span><span class="vlist-s">&ZeroWidthSpace;</span></span><span class="vlist-r"><span class="vlist" style="height: 0.686em;"><span class="" /></span></span></span></span><span class="mclose nulldelimiter" /></span><span class="mspace" style="margin-right: 0.277778em;" /><span class="mrel">=</span><span class="mspace" style="margin-right: 0.277778em;" /><span class="mord">3</span><span class="mspace" style="margin-right: 0.222222em;" /><span class="mbin">×</span><span class="mspace" style="margin-right: 0.222222em;" /><span class="mord">0</span><span class="mpunct">,</span><span class="mspace" style="margin-right: 0.166667em;" /><span class="mord">3333</span><span class="mspace" style="margin-right: 0.166667em;" /><span class="minner">…</span></span></span><span class="" style="top: -1.174em;"><span class="pstrut" style="height: 3.32144em;" /><span class="mord"><span class="mord" /><span class="mord">1</span><span class="mspace" style="margin-right: 0.277778em;" /><span class="mrel">=</span><span class="mspace" style="margin-right: 0.277778em;" /><span class="mord">0</span><span class="mpunct">,</span><span class="mspace" style="margin-right: 0.166667em;" /><span class="mord">9999</span><span class="mspace" style="margin-right: 0.166667em;" /><span class="minner">…</span></span></span></span><span class="vlist-s">&ZeroWidthSpace;</span></span><span class="vlist-r"><span class="vlist" style="height: 2.80744em;"><span class="" /></span></span></span></span></span></span></span></span></span></span>
          </span>

          <p class="mb-0">
            Cette identité est connue sous le nom de
            <a href="https://fr.wikipedia.org/wiki/D%C3%A9veloppement_d%C3%A9cimal_de_l%27unit%C3%A9">Développement décimal de l'unité</a>.
          </p>
        </big-card>
      </cards-row>
    </page-content>
    <page-error v-else :error="error" />
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
