<template>
  <div class="pt-5 pb-5">
    <big-card class="mb-5" blue>
      <comment-form :lesson="lesson" />
    </big-card>
    <div v-if="comments.length > 0">
      <comment
        v-for="(comment, index) in comments"
        :key="comment.id"
        class="mb-5"
        :class="{'mt-5': index === 0}"
        :comment="comment"
      />
    </div>
    <em v-else class="text-muted text-center d-block pt-5 pb-5">
      Il n'y a pas de commentaire sur ce cours pour le moment.
    </em>
    <client-only v-if="commentCount > 0 && comments.length < commentCount">
      <infinite-loading @infinite="fetchOlderComments">
        <template #spinner>
          <spring-spinner />
        </template>
      </infinite-loading>
    </client-only>
  </div>
</template>

<script>
import InfiniteLoading from 'vue-infinite-loading'
import SpringSpinner from '../../SpringSpinner'
import BigCard from '../../Cards/BigCard'
import CommentForm from './CommentForm'
import Comment from './Comment'

export default {
  name: 'CommentSection',
  components: { InfiniteLoading, SpringSpinner, Comment, BigCard, CommentForm },
  props: {
    lesson: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      commentCount: 0,
      comments: []
    }
  },
  async fetch () {
    this.commentCount = (
      await this.$content('comments')
        .where({ level: { $eq: this.lesson.level }, lesson: { $eq: this.lesson.id } })
        .only('_id')
        .fetch()
    ).length
    await this.fetchOlderComments()
  },
  methods: {
    async fetchOlderComments ($state) {
      this.comments = this.comments.concat(
        await this.$content('comments')
          .where({ level: { $eq: this.lesson.level }, lesson: { $eq: this.lesson.id } })
          .skip(this.comments.length)
          .limit(5)
          .sortBy('date', 'desc')
          .fetch()
      )
      if (this.comments.length >= this.commentCount) {
        $state?.complete()
      } else {
        $state?.loaded()
      }
    }
  }
}
</script>
