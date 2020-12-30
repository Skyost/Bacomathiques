<template>
  <page-content class="pt-5">
    <social-head :title="title" />
    <error-card :error-code="error.statusCode" />
  </page-content>
</template>

<script>
import PageContent from '../components/PageContent'
import SocialHead from '../components/SocialHead'
import ErrorCard from '../components/Cards/ErrorCard'

export default {
  components: { ErrorCard, SocialHead, PageContent },
  layout: 'error',
  props: {
    error: {
      type: Object,
      default: null
    }
  },
  head () {
    return {
      title: this.buildBrowserTitle(this.title)
    }
  },
  computed: {
    title () {
      return `Erreur ${this.error.statusCode}`
    }
  }
}
</script>
