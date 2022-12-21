<template>
  <Head class="page-head">
    <Title>{{ title }}</Title>
    <Meta name="description" :content="description" />
    <Meta name="og:title" :content="title" />
    <Meta name="og:description" :content="description" />
    <Meta name="og:type" content="website" />
    <Meta name="og:site_name" :content="siteName" />
    <Meta name="og:url" :content="currentAddress" />
    <Meta name="og:image" :content="openGraphImage" />
    <Meta name="og:locale" content="fr" />
    <Meta name="twitter:card" :content="twitterCard" />
    <Meta name="twitter:title" :content="title" />
    <Meta name="twitter:description" :content="description" />
    <Meta name="twitter:site" content="@Skyost" />
    <Meta name="twitter:creator" content="@Skyost" />
    <Meta name="twitter:url" :content="currentAddress" />
    <Meta name="twitter:image" :content="twitterImage" />
    <Link rel="canonical" :href="$route.path" />
    <slot />
  </Head>
</template>

<script>
import site from '~/site'

export default {
  props: {
    title: {
      type: String,
      required: true
    },
    description: {
      type: String,
      default: site.description
    },
    openGraphImage: {
      type: String,
      default: `${site.host}/img/social/open-graph.png`
    },
    twitterCard: {
      type: String,
      default: 'summary'
    },
    twitterImage: {
      type: String,
      default: `${site.host}/img/social/twitter.png`
    }
  },
  computed: {
    siteName () {
      return site.name
    },
    currentAddress () {
      return site.getCurrentAddress(this.$route)
    }
  }
}
</script>

<style lang="scss" scoped>
.page-head {
  display: none;
}
</style>
