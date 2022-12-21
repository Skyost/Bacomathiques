<template>
  <span :class="`lesson-info difficulties level-${difficulty}`" title="Difficulté du cours">
    <ski-icon v-for="i in 5" :key="i" icon="pencil-fill" :class="{'colored': i <= difficulty}" />
    {{ difficultyText }}
  </span>
</template>

<script>
export default {
  props: {
    difficulty: {
      type: Number,
      required: true
    }
  },
  computed: {
    difficultyText () {
      switch (this.difficulty) {
        case 1:
          return 'Facile'
        case 2:
          return 'Modéré'
        case 3:
          return 'Moyen'
        case 4:
          return 'Difficile'
        case 5:
        default:
          return 'Complexe'
      }
    }
  }
}
</script>

<style lang="scss">
.difficulties {
  margin-bottom: 1rem;

  .bi-icon {
    color: rgba(white, 0.75);
  }

  &.level-1 .colored {
    color: #27ae60;
  }

  &.level-2 .colored {
    color: #16a085;
  }

  &.level-3 .colored {
    color: #f1c40f;
  }

  &.level-4 .colored {
    color: #d35400;
  }

  &.level-5 .colored {
    color: #912c21;
  }
}
</style>
