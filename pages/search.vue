<template>
  <div>
    <social-head :title="title" />

    <page-header>
      <image-header image="/img/search.svg">
        <h3>Résultat de la recherche</h3>
        <p class="mb-0">
          Votre recherche <q v-text="keywords" />
          a retourné <strong v-text="result.length" /> résultat(s).
        </p>
      </image-header>
    </page-header>

    <page-content>
      <cards-row v-if="result.length > 0">
        <lesson-card v-for="lesson in result" :key="`${lesson.level}-${lesson.id}`" :lesson="lesson" />
      </cards-row>

      <div v-if="result.length === 0" class="text-center mt-5 mb-5 pt-5 pr-2 pb-5 pl-2">
        <p>
          Nous n'avons aucun résultat de recherche à vous afficher.
          À la place, voici un petit résultat qui peut sembler surprenant :
        </p>

        <span class="d-block mt-4 mb-4">
          \[
          \frac{1}{3} = 0.3333 \dots \\
          \iff 3 \times \frac{1}{3} = 3 \times 0.3333 \dots \\
          \iff 1 = 0.9999 \dots
          \]
        </span>

        <p class="mb-0">
          Ce résultat est connu sous le nom de
          <a href="https://fr.wikipedia.org/wiki/D%C3%A9veloppement_d%C3%A9cimal_de_l%27unit%C3%A9">Développement décimal de l'unité</a>.
        </p>
      </div>
    </page-content>
  </div>
</template>

<script>
import PageHeader from '../components/PageHeader'
import ImageHeader from '../components/ImageHeader'
import PageContent from '../components/PageContent'
import CardsRow from '../components/Cards/CardsRow'
import LessonCard from '../components/Cards/LessonCard'
import SocialHead from '../components/SocialHead'
export default {
  components: { SocialHead, LessonCard, CardsRow, PageContent, ImageHeader, PageHeader },
  data () {
    return {
      title: 'Résultat de la recherche',
      keywords: '😉',
      result: []
    }
  },
  head () {
    return {
      title: this.buildBrowserTitle(this.title)
    }
  },
  async mounted () {
    if (Object.prototype.hasOwnProperty.call(this.$route.query, 'requete')) {
      const keywords = this.$route.query.requete
      let result = []
      const levels = await this.$content('levels').fetch()
      for (const level of levels) {
        const lessons = await this.$content('lessons', level.id).search(keywords).fetch()
        for (const lesson of lessons) {
          lesson.name = `${lesson.name} (${level.name})`
        }
        result = [...result, ...lessons]
      }
      this.keywords = keywords
      this.result = result
    }

    if (this.result.length === 0) {
      this.renderMathJax()
    }
  }
}
</script>

<router>
  path: /recherche/
</router>

<style lang="scss" scoped>
#page-content {
  padding-bottom: 0 !important;
}
</style>
