<script setup lang="ts">
import { site } from '~/site/site'

withDefaults(defineProps<{
  title: string
  description?: string
  openGraphImage?: string
  twitterCard?: string
  twitterImage?: string
}>(), {
  description: site.description,
  openGraphImage: `${site.host}/images/social/open-graph.png`,
  twitterCard: 'summary',
  twitterImage: `${site.host}/images/social/twitter.png`
})

const route = useRoute()
const currentAddress = `${site.host}${route.path}`
</script>

<template>
  <Head class="page-head">
    <Title>{{ title }}</Title>
    <Meta
      name="description"
      :content="description"
    />
    <Meta
      name="og:title"
      :content="title"
    />
    <Meta
      name="og:description"
      :content="description"
    />
    <Meta
      name="og:type"
      content="website"
    />
    <Meta
      name="og:site_name"
      :content="site.name"
    />
    <Meta
      name="og:url"
      :content="currentAddress"
    />
    <Meta
      name="og:image"
      :content="openGraphImage"
    />
    <Meta
      name="og:locale"
      content="fr"
    />
    <Meta
      name="twitter:card"
      :content="twitterCard"
    />
    <Meta
      name="twitter:title"
      :content="title"
    />
    <Meta
      name="twitter:description"
      :content="description"
    />
    <Meta
      name="twitter:site"
      content="@Skyost"
    />
    <Meta
      name="twitter:creator"
      content="@Skyost"
    />
    <Meta
      name="twitter:url"
      :content="currentAddress"
    />
    <Meta
      name="twitter:image"
      :content="twitterImage"
    />
    <Link
      rel="canonical"
      :href="currentAddress"
    />
    <slot />
  </Head>
</template>

<style lang="scss" scoped>
.page-head {
  display: none;
}
</style>
