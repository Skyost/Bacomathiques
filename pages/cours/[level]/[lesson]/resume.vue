<script setup>
import { useLazyAsyncData, useHead, useRoute } from 'nuxt/app'

const route = useRoute()
const { pending, data: lesson } = useLazyAsyncData(
  () => queryContent('generated', 'summaries', route.params.level, route.params.lesson)
    .findOne()
)

useHead({
  script: [
    { src: '/js/funding_choices.js' }
  ]
})
</script>

<template>
  <page-loading v-if="pending" />
  <Lesson v-else-if="lesson" :lesson="lesson" :is-summary="true" />
  <page-error v-else error-code="404" />
</template>

<script>
import PageLoading from '~/components/PageLoading'
import PageError from '~/components/PageError'
import Lesson from '~/components/Lesson/Lesson'

export default {
  components: { PageLoading, PageError, Lesson }
}
</script>
