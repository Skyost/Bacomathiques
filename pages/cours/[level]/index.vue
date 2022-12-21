<script setup>
import { useLazyAsyncData, useRoute } from 'nuxt/app'

const route = useRoute()
const { pending, data: lessons } = useLazyAsyncData(
  () => queryContent('generated', 'lessons', route.params.level)
    .sort({ chapter: 1 })
    .find()
)
</script>

<template>
  <div v-if="level">
    <page-head :title="`Liste des cours de ${level.name}`" />

    <page-header>
      <image-header :image="level.image">
        <h3 v-text="level.name" />
        <p class="mb-0" v-html="level.description" />
      </image-header>
    </page-header>

    <page-loading v-if="pending" />
    <page-content v-else class="pt-0">
      <cards-row>
        <lesson-card
          v-for="lesson in lessons"
          :key="lesson.id"
          class="col-lg-5 col-xl-4 col-12 mb-xl-5"
          :lesson="lesson"
        />
      </cards-row>
    </page-content>
  </div>
  <page-error v-else error-code="404" />
</template>

<script>
import ImageHeader from '~/components/ImageHeader'
import PageContent from '~/components/PageContent'
import PageLoading from '~/components/PageLoading'
import PageHeader from '~/components/PageHeader'
import PageHead from '~/components/PageHead'
import PageError from '~/components/PageError'
import LessonCard from '~/components/Cards/LessonCard'
import { levels } from '~/utils/lesson'

export default {
  components: { LessonCard, PageError, PageHead, PageHeader, PageContent, PageLoading, ImageHeader },
  computed: {
    level () {
      return levels[this.$route.params.level]
    }
  }
}
</script>

<style lang="scss" scoped>
@import 'assets/bootstrap-mixins';

#page-header {
  padding-bottom: 70px;

  @include media-breakpoint-down(md) {
    padding-bottom: 40px;
  }
}
</style>
