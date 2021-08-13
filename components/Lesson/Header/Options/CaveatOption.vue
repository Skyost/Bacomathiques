<template>
  <div class="d-inline-block">
    <lesson-header-option
      id="caveat"
      v-b-modal.modal-caveat
      title="Signaler une erreur"
    />
    <b-modal id="modal-caveat" title="Signaler une erreur" hide-footer>
      <p>Pour apporter une correction à un cours, vous avez deux solutions :</p>
      <ul>
        <li>
          Vous pouvez <nuxt-link to="/a-propos/#contact">me contacter</nuxt-link> en m'indiquant où se trouve la
          faute ou l'amélioration que vous souhaitez apporter.
        </li>
        <li>
          Vous pouvez modifier directement le
          <a :href="`${github}/edit/master/latex/lessons/${lesson.level}/${lesson.id}.tex`">code source</a> de la page.
        </li>
      </ul>
    </b-modal>
  </div>
</template>

<script>
import LessonHeaderOption from './LessonHeaderOption'
import { GITHUB } from '~/utils/site'

export default {
  name: 'CaveatOption',
  components: { LessonHeaderOption },
  props: {
    lesson: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      github: GITHUB
    }
  }
}
</script>
