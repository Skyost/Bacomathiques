<template>
  <flat-card class="lesson-card">
    <div class="lesson-card-content">
      <img class="lesson-preview" :src="previewImage" :alt="lesson.title">
      <span class="lesson-caption" v-html="lesson.caption" />
      <span class="text-muted text-uppercase">
        <span v-if="showLevel">{{ levelName }} •</span> Chapitre {{ chapter }}
      </span>
      <h3 class="lesson-title" v-html="lesson.title" />
      <p class="lesson-description" v-html="lesson.excerpt" />
      <ski-button
        :to="`/cours/${lesson.level}/${lesson.id}/`"
        :variant="variant"
        class="d-block"
      >
        Lire ce cours
      </ski-button>
    </div>
  </flat-card>
</template>

<script>
import FlatCard from '~/components/Cards/FlatCard'
import { getLessonPreviewImage, levels } from '~/utils/lesson'
import { romanize } from '~/utils/utils'

export default {
  components: { FlatCard },
  props: {
    lesson: {
      type: Object,
      default: null
    },
    showLevel: {
      type: String,
      default: null
    }
  },
  computed: {
    levelName () {
      return levels[this.lesson.level].name
    },
    chapter () {
      return romanize(this.lesson.chapter)
    },
    variant () {
      return 'specialty' in this.lesson && this.lesson.specialty ? 'green' : 'blue'
    },
    previewImage () {
      return getLessonPreviewImage(this.lesson)
    }
  }
}
</script>

<style lang="scss" scoped>
@import 'assets/colors';

.lesson-card {
  margin-bottom: 5rem;

  :deep(.flat-card-content) {
    padding: 0;
  }

  .lesson-card-content {
    $image-height: 130px;
    $horizontal-padding: 20px;

    position: relative;
    display: flex;
    flex-direction: column;
    text-align: left;
    overflow: hidden;
    max-width: 1600px;
    margin: auto;
    padding: ($image-height + $horizontal-padding) $horizontal-padding $horizontal-padding $horizontal-padding;
    height: 100%;

    .lesson-preview {
      position: absolute;
      top: 0;
      left: 50%;
      transform: translateX(-50%);
      height: $image-height;
    }

    .lesson-caption {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: $image-height;
      background-color: rgba(black, 0.7);
      color: white;
      text-align: center;
      opacity: 0;
      transition: opacity 300ms ease;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      padding: 5px 10px;

      &:hover {
        opacity: 1;
      }
    }

    .lesson-title {
      margin-bottom: 0.75rem;
    }

    .lesson-description {
      flex: 1;
      margin-bottom: 2rem;
      color: rgba(black, 0.75);
    }
  }
}
</style>
