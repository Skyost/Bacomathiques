<template>
  <div>
    <social-head />

    <page-header>
      <carousel />
    </page-header>

    <page-content>
      <section class="pb-5">
        <feature-cards />
      </section>

      <section class="pt-5 pb-5">
        <big-card blue sal="slide-right">
          <levels />
        </big-card>
      </section>

      <section class="pt-5 pb-5">
        <mobile-banner />
      </section>

      <section class="pt-5 pb-5">
        <big-card sal="zoom-out">
          <reviews />
        </big-card>
      </section>
    </page-content>
  </div>
</template>

<script>
import sal from 'sal.js'
import PageHeader from '../components/PageHeader'
import Carousel from '../components/Carousel/Carousel'
import PageContent from '../components/PageContent'
import Reviews from '../components/Home/Reviews'
import BigCard from '../components/Cards/BigCard'
import Levels from '../components/Home/Levels'
import FeatureCards from '../components/Home/FeatureCards'
import MobileBanner from '../components/Home/MobileBanner'
import SocialHead from '../components/SocialHead'

export default {
  components: { SocialHead, FeatureCards, Levels, PageContent, PageHeader, Carousel, Reviews, BigCard, MobileBanner },
  head () {
    return {
      title: this.buildBrowserTitle('Accueil')
    }
  },
  mounted () {
    sal({
      threshold: window.outerWidth <= 768 ? 0.1 : 0.25
    })
  }
}
</script>

<style lang="scss">
@import "sal.js/dist/sal.css";
</style>

<router>
  path: /
</router>
