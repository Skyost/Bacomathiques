<template>
  <div id="lesson-header">
    <h3 v-text="lesson.title" />
    <h4 v-if="isSummary" class="lesson-subtitle">
      Fiche résumée
    </h4>

    <span class="lesson-info level" title="Niveau du cours">
      <img :src="level.image" :alt="level.name"> {{ level.name }}
    </span>
    <lesson-header-difficulty :difficulty="lesson.difficulty" />

    <p v-html="lesson.excerpt" />

    <b-btn v-if="isSummary" class="btn-white" :to="`/cours/${level.id}/${lesson.id}/`" block>
      Retour au cours
    </b-btn>
    <b-row v-else>
      <b-col cols="12" lg="6" class="mb-lg-0 mb-2">
        <b-btn
          class="btn-white w-100 h-100 d-flex justify-content-center align-items-center"
          :to="`/cours/${level.id}/${lesson.id}/resume/`"
        >
          Lire le résumé
        </b-btn>
      </b-col>
      <b-col cols="12" lg="6">
        <b-btn class="btn-white w-100" @click="showOptions = !showOptions">
          Plus d'options
          <span class="hint">Télécharger le PDF, partager, ...</span>
        </b-btn>
      </b-col>
      <b-col lg="12" class="options" :class="{expanded: showOptions}">
        <pdf-option :lesson="lesson" />
        <share-option :lesson="lesson" />
        <caveat-option :lesson="lesson" />
        <e3-c-option :lesson="lesson" />
      </b-col>
    </b-row>
  </div>
</template>

<script>
import LessonHeaderDifficulty from './LessonHeaderDifficulty'
import PdfOption from './Options/PdfOption'
import ShareOption from './Options/ShareOption'
import CaveatOption from './Options/CaveatOption'
import E3COption from './Options/E3COption'

export default {
  name: 'LessonHeaderContent',
  components: { E3COption, CaveatOption, ShareOption, PdfOption, LessonHeaderDifficulty },
  props: {
    level: {
      type: Object,
      required: true
    },
    lesson: {
      type: Object,
      required: true
    },
    isSummary: {
      type: Boolean,
      default: false
    }
  },
  data () {
    return {
      showOptions: false
    }
  }
}
</script>

<style lang="scss">
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

    &.expanded {
      padding-top: 20px;
      opacity: 1;
    }
  }
}
</style>
