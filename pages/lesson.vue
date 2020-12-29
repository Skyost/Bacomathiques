<template>
  <div v-if="lesson">
    <social-head :title="pageTitle" :description="lesson.excerpt" />

    <smart-banner />

    <page-header v-if="level">
      <lesson-header :level="level" :lesson="lesson" :is-summary="isSummary" />
    </page-header>

    <b-container v-if="lessonContent" id="page-lesson" class="mb-5" fluid="">
      <lesson-content :content="lessonContent" :lesson="lesson" />
    </b-container>

    <comment-section v-if="!isSummary" :lesson="lesson" />
  </div>
</template>

<script>
import PageHeader from '../components/PageHeader'
import LessonHeader from '../components/Lesson/Header/LessonHeader'
import CommentSection from '../components/Lesson/Comments/CommentSection'
import SmartBanner from '../components/Lesson/SmartBanner/SmartBanner'
import SocialHead from '../components/SocialHead'
import LessonContent from '../components/Lesson/LessonContent'

export default {
  name: 'Lesson',
  components: { LessonContent, SocialHead, SmartBanner, CommentSection, LessonHeader, PageHeader },
  data () {
    return {
      lessonContent: null,
      level: null,
      lesson: null
    }
  },
  async fetch () {
    this.lessonContent = await this.$content('markdown', this.isSummary ? 'summaries' : 'lessons', this.$route.params.level, this.$route.params.lesson).fetch()
    this.level = await this.$content('levels', this.$route.params.level).fetch()
    this.lesson = await this.$content('lessons', this.$route.params.level, this.$route.params.lesson).fetch()
  },
  head () {
    return {
      title: this.pageTitle,
      script: [
        { hid: 'funding-choices', src: '/js/funding_choices.js' }
      ],
      meta: [
        { hid: 'description', name: 'description', content: this.lesson?.excerpt }
      ]
    }
  },
  computed: {
    pageTitle () {
      if (!this.lesson || !this.level) {
        return null
      }

      let result = `${this.level.name} > ${this.lesson.title}`
      if (this.isSummary) {
        result += ' > Fiche résumée'
      }
      return this.buildBrowserTitle(result)
    },
    isSummary () {
      return this.$route.path.endsWith('/resume/') || this.$route.path.endsWith('/resume')
    }
  }
  // TODO: Same here https://youtrack.jetbrains.com/issue/WEB-46175.
}
</script>

<router>
  path: /cours/:level/:lesson/
  alias:
    - /cours/:level/:lesson/resume/
</router>

<style lang="scss" scoped>
@import "assets/colors";

#page-lesson {
  background: linear-gradient(180deg, $main-color 110px, transparent 110px);
  padding-bottom: 20px;
}
</style>
