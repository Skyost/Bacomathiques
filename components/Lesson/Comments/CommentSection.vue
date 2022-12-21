<script setup>
import { useLazyAsyncData } from 'nuxt/app'
import { toRefs } from 'vue'

const props = defineProps({
  lesson: {
    type: Object,
    required: true
  }
})

const { lesson } = toRefs(props)
const { pending, data: comments } = useLazyAsyncData(() => queryContent('comments')
  .where({ level: lesson.value.level, lesson: lesson.value.id })
  .sort({ date: -1 })
  .find()
)
</script>

<template>
  <div class="pt-5 pb-5">
    <big-card class="mb-5" blue>
      <comment-form :lesson="lesson" />
    </big-card>
    <div v-if="pending">
      <spring-spinner />
    </div>
    <div v-else-if="comments && comments.length > 0">
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
  </div>
</template>

<script>
import BigCard from '~/components/Cards/BigCard'
import CommentForm from '~/components/Lesson/Comments/CommentForm'
import Comment from '~/components/Lesson/Comments/Comment'

export default {
  components: { Comment, BigCard, CommentForm }
}
</script>
