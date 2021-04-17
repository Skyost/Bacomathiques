<template>
  <page-loading v-if="$fetchState.pending" />
  <div v-else-if="level && lesson">
    <lesson :level="level" :lesson="lesson" />
  </div>
  <page-error v-else :error-code="404" />
</template>

<script>
import PageLoading from '../components/PageLoading'
import PageError from '../components/PageError'
import Lesson from '../components/Lesson/Lesson'
import { buildBrowserLessonTitle } from '~/utils/lesson'

export default {
  components: { PageError, PageLoading, Lesson },
  data () {
    return {
      level: null,
      lesson: null
    }
  },
  async fetch () {
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

      return buildBrowserLessonTitle(this.level, this.lesson)
    }
  }
}
</script>

<router>
  path: /cours/:level/:lesson/
</router>
