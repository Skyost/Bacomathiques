<script setup lang="ts">
import { levels } from '~/site/site'
import MathDocument from '~/components/Math/MathDocument.vue'
import type { Toc } from '~/types'

const route = useRoute()

const routeParam = (param: string | string[] | undefined) => Array.isArray(param) ? param[0] : param
const levelParam = routeParam(route.params.level)
const lessonParam = routeParam(route.params.lesson)
const slugParam = routeParam(route.params.slug) ?? ''

const isLesson = slugParam === ''
const isSummary = slugParam === 'resume'
const level = levelParam ? levels[levelParam] : undefined

const { error, pending, data: lesson } = useLazyAsyncData(
  route.path,
  () => queryCollection('lessons')
    .where('level', '=', levelParam ?? '')
    .where('slug', '=', lessonParam ?? '')
    .first()
)

const { data: comments } = useLazyAsyncData(
  `${route.path}?comments`,
  () => queryCollection('comments')
    .where('level', '=', levelParam ?? '')
    .where('lesson', '=', lessonParam ?? '')
    .order('date', 'DESC')
    .all()
)

const toc = computed(() => lesson.value?.toc as Toc | undefined)

const config = useRuntimeConfig()
if (!config.public.debug) {
  useHead({
    script: [
      { src: '/js/funding_choices.js' }
    ]
  })
}
</script>

<template>
  <page-loading v-if="pending" />
  <div v-else-if="(isLesson || isSummary) && level && lesson">
    <page-head
      :title="`${level.name} > ${lesson!.title}${isSummary ? ' > Fiche résumée' : ''}`"
      :description="lesson!.description"
    />
    <smart-banner />
    <page-header class="page-header">
      <lesson-header
        :level="level"
        :lesson="lesson!"
        :is-summary="isSummary"
      />
    </page-header>
    <math-document
      class="page-lesson"
      :comments="isLesson ? comments! : undefined"
      :toc="toc"
    >
      <page-content class="page-content">
        <div v-html="isSummary ? lesson!.summary : lesson!.body" />
      </page-content>
      <template #comments-headings>
        <h2>Vous avez aimé ce cours ?</h2>
        <p>Faîtes-le nous savoir dans les commentaires !</p>
      </template>
      <template #comments-inputs>
        <input
          name="lesson"
          type="hidden"
          :value="lesson!.slug"
        >
        <input
          name="level"
          type="hidden"
          :value="lesson!.level"
        >
      </template>
    </math-document>
  </div>
  <page-error
    v-else
    :error="error"
  />
</template>

<style lang="scss">
@import '~/assets/highlighting';
</style>

<style lang="scss" scoped>
@import '~/assets/bootstrap-mixins';
@import '~/assets/colors';

.page-header {
  padding: 50px 0;

  @include media-breakpoint-down(md) {
    padding: 30px 0;
  }

  @include media-breakpoint-down(sm) {
    padding-top: 10px;
    padding-bottom: 0;
  }
}

.page-lesson {
  background: linear-gradient(180deg, $primary 110px, transparent 110px);
  padding-bottom: 20px;
}

.page-content {
  background-color: white;
  padding: 40px;
  text-align: left;
  box-shadow: 0 0 30px rgba(black, 0.2);
  z-index: 1;
  counter-reset: headline-2 headline-3;

  @include media-breakpoint-down(md) {
    padding-left: 20px;
    padding-right: 20px;
  }
}
</style>
