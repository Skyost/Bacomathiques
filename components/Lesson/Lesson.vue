<template>
  <div>
    <social-head :title="pageTitle" :description="lesson.excerpt" />

    <smart-banner />

    <page-header v-if="level">
      <lesson-header :level="level" :lesson="lesson" :is-summary="isSummary" />
    </page-header>

    <b-container v-if="content" id="page-lesson" class="mb-5" fluid="">
      <lesson-content :content="content" :lesson="lesson" :is-summary="isSummary" />
    </b-container>

    <comment-section v-if="!isSummary" :lesson="lesson" />
  </div>
</template>

<script>
import SocialHead from '../SocialHead'
import PageHeader from '../PageHeader'
import CommentSection from './Comments/CommentSection'
import LessonContent from './LessonContent'
import SmartBanner from './SmartBanner/SmartBanner'
import LessonHeader from './Header/LessonHeader'
import { buildBrowserLessonTitle } from '~/utils/lesson'

export default {
  name: 'Lesson',
  components: { LessonContent, SocialHead, SmartBanner, LessonHeader, PageHeader, CommentSection },
  props: {
    level: {
      type: Object,
      required: true
    },
    lesson: {
      type: Object,
      required: true
    },
    isSummary: {
      type: Boolean,
      default: false
    }
  },
  data () {
    return {
      content: null
    }
  },
  async fetch () {
    this.content = await this.$content('markdown', this.isSummary ? 'summaries' : 'lessons', this.$route.params.level, this.$route.params.lesson)
      .fetch()
  },
  computed: {
    pageTitle () {
      return buildBrowserLessonTitle(this.level, this.lesson, this.isSummary)
    }
  }
}
</script>

<style lang="scss" scoped>
@import 'assets/colors';

#page-lesson {
  background: linear-gradient(180deg, $main-color 110px, transparent 110px);
  padding-bottom: 20px;
}
</style>
