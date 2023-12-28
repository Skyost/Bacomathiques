<script setup lang="ts">
import { levels } from '~/site/site'
import type { Comment as _Comment, Lesson } from '~/types'
import MathDocument from '~/components/Math/MathDocument.vue'
import { siteContentSettings } from '~/site/content'

const route = useRoute()

const isLesson = route.params.slug === ''
const isSummary = route.params.slug === 'resume'
const level = levels[route.params.level.toString()]

interface LessonContent extends Lesson {
  body: string,
  toc: string
}

interface LessonSummaryContent extends Lesson {
  summary: string,
  toc: string
}

const { error, pending, data: lesson } = useLazyAsyncData(
  route.path,
  () => queryContent<LessonContent | LessonSummaryContent>(
    siteContentSettings.dataLatexDirectory,
    route.params.level.toString(),
    route.params.lesson.toString()
  )
    .without(isLesson ? ['summary'] : ['body'])
    .findOne()
)

const { data: comments } = useLazyAsyncData(
  `${route.path}?comments`,
  () => queryContent<_Comment>('comments')
    .where({ level: route.params.level.toString(), lesson: route.params.lesson.toString() })
    .sort({ date: -1 })
    .find()
)

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
  <div v-else-if="(isLesson || isSummary) && lesson">
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
    <math-document class="page-lesson" :comments="isLesson ? comments! : undefined" :ads="true" :toc="lesson!.toc">
      <page-content class="page-content">
        <div v-html="'body' in lesson ? lesson!.body : lesson!.summary" />
      </page-content>
      <template #comments-headings>
        <h2>Vous avez aimé ce cours ?</h2>
        <p>Faîtes-le nous savoir dans les commentaires !</p>
      </template>
      <template #comments-inputs>
        <input name="lesson" type="hidden" :value="lesson!.id">
        <input name="level" type="hidden" :value="lesson!.level">
      </template>
    </math-document>
  </div>
  <page-error v-else :error="error" />
</template>

<style lang="scss" scoped>
@import 'assets/bootstrap-mixins';
@import 'assets/colors';
@import 'assets/highlighting';

.page-header {
  padding: 50px 0;
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
