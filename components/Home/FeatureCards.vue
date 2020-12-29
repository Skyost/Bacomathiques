<template>
  <cards-row sal="slide-up">
    <small-card
      v-for="card in featureCards"
      :key="card.id"
      class="mb-5"
      :image="`/img/index/features/${card.id}.svg`"
      :size="3"
    >
      <span v-html="card.content" />
    </small-card>
  </cards-row>
</template>

<script>
import CardsRow from '../Cards/CardsRow'
import SmallCard from '../Cards/SmallCard'
export default {
  name: 'FeatureCards',
  components: { SmallCard, CardsRow },
  data () {
    return {
      featureCards: [
        {
          id: 'book',
          content: 'Des cours en accord avec <strong>les programmes officiels</strong> du ministère de l\'Éducation nationale.'
        },
        {
          id: 'check',
          content: 'Des exemples intuitifs et la possibilité de <strong>télécharger</strong> et <strong>imprimer les cours</strong> gratuitement pour les relire chez soi !'
        },
        {
          id: 'computer',
          content: 'Le plus important : <strong>tout est gratuit</strong>. Même pas besoin de compte, tout est à disposition de tout le monde !'
        }
      ]
    }
  }
}
</script>
