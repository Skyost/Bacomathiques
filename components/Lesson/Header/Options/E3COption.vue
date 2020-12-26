<template>
  <div v-if="e3c.length > 0" class="d-inline-block">
    <lesson-header-option
      id="e3c"
      v-b-modal.modal-e3c
      title="Voir les E3C en rapport avec le cours"
    />
    <b-modal id="modal-e3c" title="E3C en rapport avec le cours" size="lg" hide-footer>
      <div v-for="data in e3c" :key="data.id" class="modal-e3c-item row">
        <h3 class="col-12 modal-e3c-item-id text-center mb-4" v-text="data.id" />
        <div class="col-12">
          <a :href="data.subject" class="d-block w-100 btn btn-green col-12">Voir le sujet</a>
        </div>
        <div
          v-for="correction in data.corrections"
          :key="getSiteName(correction)"
          class="col-xs-12 mt-3 mr-auto ml-auto"
          :class="{'col-md-12': data.corrections.length === 1, 'col-md-6': data.corrections.length !== 1}"
        >
          <a :href="correction" class="d-block w-100 btn btn-blue">
            Correction par
            <br>{{ getSiteName(correction) }}
          </a>
        </div>
      </div>
      <small class="d-block text-right mt-4">
        Sujets disponibles en libre accès sur
        <a href="http://quandjepasselebac.education.fr/revisions-la-banque-nationale-de-sujets/">le site du ministère</a>.
        <br>Merci à <a href="https://ccbac.fr/index.php">CCBac</a> pour la liste des corrigés.
        <br>Une erreur ou un manque dans cette liste ?
        <a v-b-modal.modal-caveat href="#">Proposez votre correction</a> !
      </small>
    </b-modal>
  </div>
</template>

<script>
import LessonHeaderOption from './LessonHeaderOption'

export default {
  name: 'E3COption',
  components: { LessonHeaderOption },
  props: {
    lesson: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      e3c: []
    }
  },
  async fetch () {
    this.e3c = await this.$content('e3c')
      .where({
        $and: [
          { 'lessons.level': { $contains: this.lesson.level } },
          { 'lessons.lesson': { $contains: this.lesson.id } }
        ]
      })
      .fetch()
  },
  methods: {
    getSiteName (correction) {
      let parts = correction.split('://')
      parts = parts[1].split('/')
      parts = parts[0].split('www.')
      return parts.length > 1 ? parts[1] : parts[0]
    }
  }
}
</script>

<style lang="scss">
#modal-e3c {
  .modal-e3c-item {
    $background-color: #e3f2fd;

    margin: 15px 15px 0 15px;
    padding: 20px;
    background-color: $background-color;

    .modal-e3c-item-id {
      color: darken($background-color, 50%);
    }
  }

  .modal-e3c-item:first-child {
    margin-top: 0;
  }
}
</style>
