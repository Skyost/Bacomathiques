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
          À la place, voici un petit résultat mathématique qui peut sembler surprenant :
        </p>

        <span class="d-block mt-4 mb-4">
          <span class="katex-display"><span class="katex"><span class="katex-html" aria-hidden="true"><span class="base"><span class="strut" style="height: 6.11488em; vertical-align: -2.80744em;"></span><span class="mord"><span class="mtable"><span class="col-align-r"><span class="vlist-t vlist-t2"><span class="vlist-r"><span class="vlist" style="height: 3.30744em;"><span class="" style="top: -5.30744em;"><span class="pstrut" style="height: 3.32144em;"></span><span class="mord"></span></span><span class="" style="top: -3em;"><span class="pstrut" style="height: 3.32144em;"></span><span class="mord"><span class="mspace" style="margin-right: 0.277778em;"></span><span class="mrel">⟺</span><span class="mspace" style="margin-right: 0.277778em;"></span></span></span><span class="" style="top: -1.174em;"><span class="pstrut" style="height: 3.32144em;"></span><span class="mord"><span class="mspace" style="margin-right: 0.277778em;"></span><span class="mrel">⟺</span><span class="mspace" style="margin-right: 0.277778em;"></span></span></span></span><span class="vlist-s">&ZeroWidthSpace;</span></span><span class="vlist-r"><span class="vlist" style="height: 2.80744em;"><span class=""></span></span></span></span></span><span class="col-align-l"><span class="vlist-t vlist-t2"><span class="vlist-r"><span class="vlist" style="height: 3.30744em;"><span class="" style="top: -5.30744em;"><span class="pstrut" style="height: 3.32144em;"></span><span class="mord"><span class="mord"></span><span class="mord"><span class="mopen nulldelimiter"></span><span class="mfrac"><span class="vlist-t vlist-t2"><span class="vlist-r"><span class="vlist" style="height: 1.32144em;"><span class="" style="top: -2.314em;"><span class="pstrut" style="height: 3em;"></span><span class="mord"><span class="mord">3</span></span></span><span class="" style="top: -3.23em;"><span class="pstrut" style="height: 3em;"></span><span class="frac-line" style="border-bottom-width: 0.04em;"></span></span><span class="" style="top: -3.677em;"><span class="pstrut" style="height: 3em;"></span><span class="mord"><span class="mord">1</span></span></span></span><span class="vlist-s">&ZeroWidthSpace;</span></span><span class="vlist-r"><span class="vlist" style="height: 0.686em;"><span class=""></span></span></span></span></span><span class="mclose nulldelimiter"></span></span><span class="mspace" style="margin-right: 0.277778em;"></span><span class="mrel">=</span><span class="mspace" style="margin-right: 0.277778em;"></span><span class="mord">0</span><span class="mpunct">,</span><span class="mspace" style="margin-right: 0.166667em;"></span><span class="mord">3333</span><span class="mspace" style="margin-right: 0.166667em;"></span><span class="minner">…</span></span></span><span class="" style="top: -3em;"><span class="pstrut" style="height: 3.32144em;"></span><span class="mord"><span class="mord"></span><span class="mord">3</span><span class="mspace" style="margin-right: 0.222222em;"></span><span class="mbin">×</span><span class="mspace" style="margin-right: 0.222222em;"></span><span class="mord"><span class="mopen nulldelimiter"></span><span class="mfrac"><span class="vlist-t vlist-t2"><span class="vlist-r"><span class="vlist" style="height: 1.32144em;"><span class="" style="top: -2.314em;"><span class="pstrut" style="height: 3em;"></span><span class="mord"><span class="mord">3</span></span></span><span class="" style="top: -3.23em;"><span class="pstrut" style="height: 3em;"></span><span class="frac-line" style="border-bottom-width: 0.04em;"></span></span><span class="" style="top: -3.677em;"><span class="pstrut" style="height: 3em;"></span><span class="mord"><span class="mord">1</span></span></span></span><span class="vlist-s">&ZeroWidthSpace;</span></span><span class="vlist-r"><span class="vlist" style="height: 0.686em;"><span class=""></span></span></span></span></span><span class="mclose nulldelimiter"></span></span><span class="mspace" style="margin-right: 0.277778em;"></span><span class="mrel">=</span><span class="mspace" style="margin-right: 0.277778em;"></span><span class="mord">3</span><span class="mspace" style="margin-right: 0.222222em;"></span><span class="mbin">×</span><span class="mspace" style="margin-right: 0.222222em;"></span><span class="mord">0</span><span class="mpunct">,</span><span class="mspace" style="margin-right: 0.166667em;"></span><span class="mord">3333</span><span class="mspace" style="margin-right: 0.166667em;"></span><span class="minner">…</span></span></span><span class="" style="top: -1.174em;"><span class="pstrut" style="height: 3.32144em;"></span><span class="mord"><span class="mord"></span><span class="mord">1</span><span class="mspace" style="margin-right: 0.277778em;"></span><span class="mrel">=</span><span class="mspace" style="margin-right: 0.277778em;"></span><span class="mord">0</span><span class="mpunct">,</span><span class="mspace" style="margin-right: 0.166667em;"></span><span class="mord">9999</span><span class="mspace" style="margin-right: 0.166667em;"></span><span class="minner">…</span></span></span></span><span class="vlist-s">&ZeroWidthSpace;</span></span><span class="vlist-r"><span class="vlist" style="height: 2.80744em;"><span class=""></span></span></span></span></span></span></span></span></span></span></span>
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
      title: this.title
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
