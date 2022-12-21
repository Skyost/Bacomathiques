<template>
  <div>
    <page-head title="À propos" />

    <page-header>
      <carousel />
    </page-header>

    <page-content>
      <section class="pb-5">
        <technologie-cards />
      </section>

      <section class="pt-5 pb-5" data-sal="slide-right">
        <big-card>
          <license-contributions />
        </big-card>
      </section>

      <section class="pt-5 pb-5">
        <big-card blue sal="slide-down">
          <contact-form />
        </big-card>
      </section>
    </page-content>
  </div>
</template>

<script>
import sal from 'sal.js'
import PageHeader from '~/components/PageHeader'
import Carousel from '~/components/Carousel/Carousel'
import PageContent from '~/components/PageContent'
import BigCard from '~/components/Cards/BigCard'
import LicenseContributions from '~/components/About/LicenseContributions'
import ContactForm from '~/components/About/ContactForm'
import PageHead from '~/components/PageHead'
import TechnologieCards from '~/components/About/TechnologieCards'

export default {
  components: { PageHead, ContactForm, LicenseContributions, TechnologieCards, PageContent, PageHeader, Carousel, BigCard },
  mounted () {
    sal({
      threshold: window.outerWidth <= 768 ? 0.1 : 0.25
    })
  }
}
</script>

<style lang="scss">
@import 'sal.js/dist/sal.css';
</style>
