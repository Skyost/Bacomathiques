<template>
  <cards-row sal="slide-up">
    <card-column
      v-for="card in technologieCards"
      :key="card.id"
      class="mb-5"
      :image="`/img/about/${card.id}.svg`"
      :size="3"
    >
      <span v-html="card.content" />
    </card-column>
  </cards-row>
</template>

<script>
import CardsRow from '~/components/Cards/CardsRow'
import CardColumn from '~/components/Cards/CardColumn'

export default {
  components: { CardColumn, CardsRow },
  data () {
    return {
      technologieCards: [
        {
          id: 'vue',
          content: 'Ce site web a été créé (notamment) avec le framework <a href="https://vuejs.org/">Vue.js</a>, vous pouvez consulter le <pre class="d-inline mb-0">package.json</pre> en cliquant <a href="https://github.com/Skyost/Bacomathiques/blob/master/package.json">ici</a>.'
        },
        {
          id: 'nuxt',
          content: 'Le site utilise le moteur <a href="https://nuxtjs.org/">Nuxt.js</a> pour générer ses contenus et est hébergé sur <a href="https://pages.github.com/">Github Pages</a>.'
        },
        {
          id: 'pencil',
          content: `Les icônes de la <a href="https://www.iconfinder.com/iconsets/small-n-flat">page de présentation</a>,
            du <a href="https://www.flaticon.com/packs/education-1-11">carousel</a>,
            des <a href="https://www.flaticon.com/packs/greek-symbols">niveaux</a>,
            des <a href="https://www.flaticon.com/packs/logos-and-brands">magasins d'applications</a>,
            de <a href="https://www.flaticon.com/free-icon/pdf_136522">fichier PDF</a>,
            d'<a href="https://www.flaticon.com/free-icon/printer_201579">imprimante</a>,
            de <a href="https://www.flaticon.com/free-icon/pdf_136522">partage</a>,
            d'<a href="https://www.flaticon.com/free-icon/pdf_136522">avertissement</a>,
            de <a href="https://www.iconfinder.com/icons/2064495/education_graduation_learn_school_student_study_icon">diplôme</a>,
            de <a href="https://www.flaticon.com/free-icon/magnifying-glass_3003596">recherche</a>,
            et <a href="https://www.iconfinder.com/iconsets/tutor-icon-set">Bacomathiques</a> proviennent de IconFinder et de FlatIcon.
            <br>Les autres icônes proviennent de <a href="https://fontawesome.io/">FontAwesome</a>.`
        }
      ]
    }
  }
}
</script>
