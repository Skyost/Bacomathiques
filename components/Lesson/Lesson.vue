<template>
  <div>
    <page-head :title="pageTitle" :description="lesson.excerpt" />

    <smart-banner />

    <page-header v-if="level">
      <lesson-header :level="level" :lesson="lesson" :is-summary="isSummary" />
    </page-header>

    <ski-container id="page-lesson" class="mb-5" :fluid="true">
      <lesson-content :lesson="lesson" />
    </ski-container>

    <comment-section v-if="!isSummary" :lesson="lesson" />
  </div>
</template>

<script>
import PageHead from '~/components/PageHead'
import PageHeader from '~/components/PageHeader'
import CommentSection from '~/components/Lesson/Comments/CommentSection'
import LessonContent from '~/components/Lesson/LessonContent'
import SmartBanner from '~/components/Lesson/SmartBanner/SmartBanner'
import LessonHeader from '~/components/Lesson/Header/LessonHeader'
import { levels } from '~/utils/lesson'

export default {
  components: { LessonContent, PageHead, SmartBanner, LessonHeader, PageHeader, CommentSection },
  props: {
    lesson: {
      type: Object,
      required: true
    },
    isSummary: {
      type: Boolean,
      default: false
    }
  },
  computed: {
    level () {
      return levels[this.lesson.level]
    },
    pageTitle () {
      const level = this.level
      let result = `${level.name} > ${this.lesson.title}`
      if (this.isSummary) {
        result += ' > Fiche résumée'
      }
      return result
    }
  }
}
</script>

<style lang="scss" scoped>
@import 'assets/colors';

:deep(#page-header) {
  padding: 50px 0;
}

#page-lesson {
  background: linear-gradient(180deg, $primary 110px, transparent 110px);
  padding-bottom: 20px;
}
</style>
