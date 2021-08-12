<template>
  <page-loading v-if="$fetchState.pending" />
  <div v-else-if="level">
    <social-head :title="title" />

    <page-header>
      <image-header :image="level.image">
        <h3 v-text="level.name" />
        <p class="mb-0" v-html="level.description" />
      </image-header>
    </page-header>

    <page-content class="pt-0">
      <lesson-list :level="level" />
    </page-content>
  </div>
  <page-error v-else :error-code="404" />
</template>

<script>
import ImageHeader from '../components/ImageHeader'
import PageContent from '../components/PageContent'
import LessonList from '../components/List/LessonList'
import PageHeader from '../components/PageHeader'
import SocialHead from '../components/SocialHead'
import PageLoading from '../components/PageLoading'
import PageError from '../components/PageError'

export default {
  components: { PageError, PageLoading, SocialHead, PageHeader, LessonList, PageContent, ImageHeader },
  data () {
    return {
      title: 'Liste des cours',
      level: null
    }
  },
  async fetch () {
    const level = await this.$content('levels', this.$route.params.level)
      .fetch()
    this.title = `Liste des cours de ${level.name}`
    this.level = level
  },
  head () {
    return {
      title: this.title
    }
  }
}
</script>

<style lang="scss" scoped>
@import 'assets/breakpoints';

#page-header {
  padding-bottom: 70px;

  @media (max-width: $mobile-width) {
    padding-bottom: 40px;
  }
}
</style>

<router>
  path: /cours/:level/
</router>
