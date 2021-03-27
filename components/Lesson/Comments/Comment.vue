<template>
  <big-card class="comment">
    <b-row>
      <b-col cols="12" lg="3" class="mb-lg-0 mb-4">
        <a :href="`#commentaire-${comment._id}`">
          <b-avatar variant="info" :src="getAvatarURL(comment.author)" />
        </a>
      </b-col>
      <b-col cols="12" lg="9" class="content">
        <h3 :id="`commentaire-${comment._id}`">
          {{ comment.author }}
          <b-badge v-if="comment.author === 'Skyost'" variant="info">
            Modérateur
          </b-badge>
        </h3>
        <div class="mb-4" v-html="comment.markdownMessage" />
        <small class="d-block text-right text-muted">{{ date }} {{ time }}</small>
      </b-col>
    </b-row>
  </big-card>
</template>

<script>
import BigCard from '../../Cards/BigCard'
export default {
  name: 'Comment',
  components: { BigCard },
  props: {
    comment: {
      type: Object,
      required: true
    }
  },
  computed: {
    date () {
      return new Date(this.comment.date * 1000).toLocaleDateString('fr-FR')
    },
    time () {
      return new Date(this.comment.date * 1000).toLocaleTimeString('fr-FR')
    }
  }
}
</script>

<style lang="scss">
.comment {
  .b-avatar {
    background-color: transparent;
    width: 100%;
    max-width: 100px;
    height: 100%;
    max-height: 100px;
  }

  .badge {
    font-size: 0.8rem;
    vertical-align: 0.15rem;
  }

  .content {
    text-align: justify;
    word-break: break-word;
  }
}
</style>
