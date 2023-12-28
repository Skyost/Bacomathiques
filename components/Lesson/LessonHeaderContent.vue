<script setup lang="ts">
import PdfOption from '~/components/Lesson/Options/PdfOption.vue'
import ShareOption from '~/components/Lesson/Options/ShareOption.vue'
import CaveatOption from '~/components/Lesson/Options/CaveatOption.vue'
import type { Lesson, Level } from '~/types'
import { levels, prependChapterToTitle } from '~/site/site'

const props = withDefaults(defineProps<{
  lesson: Lesson,
  isSummary?: boolean
}>(), {
  isSummary: false
})

const showOptions = ref<boolean>(false)
const level = computed<Level>(() => levels[props.lesson.level])
const lessonTitle = computed<string>(() => prependChapterToTitle(props.lesson))
</script>

<template>
  <div id="lesson-header">
    <h3 v-text="lessonTitle" />
    <h4 v-if="isSummary" class="lesson-subtitle">
      Fiche résumée
    </h4>

    <span class="lesson-info level" title="Niveau du cours">
      <img :src="level.image" :alt="level.name"> {{ level.name }}
    </span>
    <lesson-header-difficulty :difficulty="lesson.difficulty" />

    <p v-html="lesson.description" />

    <ski-button v-if="isSummary" class="btn-block w-100" variant="white" :to="`/cours/${level.id}/${lesson.id}/`">
      Retour au cours
    </ski-button>
    <ski-columns v-else>
      <ski-column width="12" lg="6" class="mb-lg-0 mb-2">
        <ski-button
          variant="white"
          class="btn d-flex justify-content-center align-items-center fw-bold"
          :to="`/cours/${level.id}/${lesson.id}/resume/`"
        >
          Lire le résumé
        </ski-button>
      </ski-column>
      <ski-column width="12" lg="6">
        <ski-button variant="white" class="btn" @click="showOptions = !showOptions">
          <strong>Plus d'options</strong>
          <span class="hint">Télécharger le PDF, partager, ...</span>
        </ski-button>
      </ski-column>
      <ski-column lg="12" class="options" :class="{expanded: showOptions}">
        <pdf-option :lesson="lesson" />
        <share-option :lesson="lesson" />
        <caveat-option :lesson="lesson" />
      </ski-column>
    </ski-columns>
  </div>
</template>

<style lang="scss" scoped>
#lesson-header {
  .lesson-subtitle {
    font-size: 1.2rem;
    font-style: italic;
  }

  .lesson-info {
    display: block;
    font-size: 1em;
    font-weight: normal;
    cursor: help;
  }

  .level img {
    vertical-align: -0.1em;
    height: 1em;
  }

  .hint {
    display: block;
    font-weight: normal;
    font-size: 0.8rem;
  }

  .options {
    text-align: center;
    padding-top: 0;
    opacity: 0;
    transition: all 500ms;
    color: initial !important;

    &.expanded {
      padding-top: 20px;
      opacity: 1;
    }
  }

  .btn {
    padding: 14px;
    width: 100%;
    height: 100%;
  }
}
</style>
