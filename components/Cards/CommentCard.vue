<script setup lang="ts">
import type { Comment } from '~/types'
import BigCard from '~/components/Cards/BigCard.vue'
import { getAvatarUrl, site } from '~/site/site'

const props = defineProps<{ comment: Comment }>()

const dateObject = computed<Date>(() => new Date(props.comment.date * 1000))
const date = computed<string>(() => dateObject.value.toLocaleDateString('fr-FR'))
const time = computed<string>(() => dateObject.value.toLocaleTimeString('fr-FR'))
const avatarUrl = computed<string>(() => getAvatarUrl(props.comment.author))
</script>

<template>
  <big-card class="comment">
    <ski-columns>
      <ski-column width="12" lg="3" class="mb-lg-0 mb-4">
        <a :href="`#commentaire-${comment._id}`">
          <img :src="avatarUrl" :alt="comment.author" class="avatar">
        </a>
      </ski-column>
      <ski-column width="12" lg="9" class="content">
        <h3 :id="`commentaire-${comment._id}`">
          {{ comment.author }}
          <span v-if="site.moderators.includes(comment.author)" class="badge bg-info">
            Modérateur
          </span>
        </h3>
        <p class="mb-4" v-text="comment.message" />
        <small class="d-block text-right text-muted">{{ date }} {{ time }}</small>
      </ski-column>
    </ski-columns>
  </big-card>
</template>

<style lang="scss" scoped>
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
