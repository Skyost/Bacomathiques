<template>
  <big-card class="comment">
    <ski-columns>
      <ski-column width="12" lg="3" class="mb-lg-0 mb-4">
        <a :href="`#commentaire-${comment._id}`">
          <img :src="avatarURL" :alt="comment.author" class="avatar">
        </a>
      </ski-column>
      <ski-column width="12" lg="9" class="content">
        <h3 :id="`commentaire-${comment._id}`">
          {{ comment.author }}
          <span v-if="comment.author === 'Skyost'" class="badge bg-info">
            Modérateur
          </span>
        </h3>
        <p class="mb-4" v-text="comment.message" />
        <small class="d-block text-right text-muted">{{ date }} {{ time }}</small>
      </ski-column>
    </ski-columns>
  </big-card>
</template>

<script>
import BigCard from '~/components/Cards/BigCard'
import { getAvatarURL } from '~/utils/lesson'

export default {
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
    },
    avatarURL () {
      return getAvatarURL(this.comment.author)
    }
  }
}
</script>

<style lang="scss">
.comment {
  .avatar {
    background-color: transparent;
    width: 100%;
    max-width: 100px;
    height: 100%;
    max-height: 100px;
    border-radius: 100%;
  }

  .badge {
    font-size: 0.8rem;
    vertical-align: 0.15rem;
  }

  .content {
    word-break: break-word;
    text-align: left;
  }
}
</style>
