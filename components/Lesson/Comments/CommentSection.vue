<template>
  <div class="pt-5 pb-5">
    <big-card class="mb-5" blue>
      <comment-form :lesson="lesson" />
    </big-card>
    <em v-if="comments.length === 0" class="text-muted text-center d-block pt-5 pb-5">
      Il n'y a pas de commentaire sur ce cours pour le moment.
    </em>
    <comment
      v-for="(comment, index) in comments"
      :key="comment.id"
      class="mb-5"
      :class="{'mt-5': index === 0}"
      :comment="comment"
    />
  </div>
</template>

<script>
import BigCard from '../../Cards/BigCard'
import CommentForm from './CommentForm'
import Comment from './Comment'
export default {
  name: 'CommentSection',
  components: { Comment, BigCard, CommentForm },
  props: {
    lesson: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      comments: []
    }
  },
  async mounted () {
    this.comments = await this.$content('comments')
      .where({ level: { $eq: this.lesson.level }, lesson: { $eq: this.lesson.id } })
      .sortBy('date', 'desc')
      .fetch()
  }
}
</script>
