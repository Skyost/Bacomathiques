<template>
  <small-card
    class="lesson-card"
    :image="lesson.preview"
    :size="4"
    :mb="5"
  >
    <span class="lesson-caption" v-html="lesson.caption" />
    <h3 class="lesson-title" v-html="lesson.title" />
    <p class="lesson-description" v-html="lesson.excerpt" />
    <nuxt-link
      :to="`/cours/${lesson.level}/${lesson.id}/`"
      class="lesson-link btn btn-block"
      :class="buttonClass"
      role="button"
      aria-pressed="true"
    >
      Lire ce cours
    </nuxt-link>
  </small-card>
</template>

<script>
import SmallCard from './SmallCard'
export default {
  name: 'LessonCard',
  components: { SmallCard },
  props: {
    lesson: {
      type: Object,
      default: null
    }
  },
  computed: {
    buttonClass () {
      return 'specialty' in this.lesson && this.lesson.specialty ? 'btn-green' : 'btn-blue'
    }
  }
}
</script>

<style lang="scss">
@import "assets/colors";

.lesson-card.flat-card {
  margin-bottom: 5rem;

  .flat-card-content {
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

    .flat-card-image {
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
