<template>
  <div v-if="level">
    <social-head :title="title" />

    <page-header>
      <image-header :image="level.image">
        <h3 v-text="level.name" />
        <p class="mb-0" v-html="level.description" />
      </image-header>
    </page-header>

    <page-content>
      <lesson-list :level="level" />
    </page-content>
  </div>
</template>

<script>
import ImageHeader from '../components/ImageHeader'
import PageContent from '../components/PageContent'
import LessonList from '../components/List/LessonList'
import PageHeader from '../components/PageHeader'
import SocialHead from '../components/SocialHead'
export default {
  name: 'Lesson',
  components: { SocialHead, PageHeader, LessonList, PageContent, ImageHeader },
  data () {
    return {
      title: null,
      level: null
    }
  },
  async fetch () {
    const level = await this.$content('levels', this.$route.params.level).fetch()
    this.title = `Liste des cours de ${this.level.name}`
    this.level = level
  },
  head () {
    return {
      title: this.buildBrowserTitle(this.title ?? 'Liste des cours')
    }
  }
  /*
  TODO: Update this as soon as https://youtrack.jetbrains.com/issue/WEB-46175 gets fixed.
  async asyncData ({ $content, params }) {
    const level = await $content('levels', params.level).fetch()
    return { level }
  }
  */
}
</script>

<style lang="scss" scoped>
@import "assets/breakpoints";

#page-header {
  padding-bottom: 70px;

  @media (max-width: $mobile-width) {
    padding-bottom: 40px;
  }
}

#page-content {
  padding-bottom: 0 !important;
}
</style>

<router>
  path: /cours/:level/
</router>
