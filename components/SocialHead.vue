<template>
  <span v-if="false" />
</template>

<script>
export default {
  name: 'SocialHead',
  props: {
    description: {
      type: String,
      default: null
    }
  },
  data () {
    return {
      metaTitle: null,
      metaDescription: null
    }
  },
  head () {
    return {
      meta: [
        { property: 'og:title', content: this.metaTitle },
        { property: 'og:description', content: this.description ?? this.metaDescription },
        { property: 'og:type', content: 'website' },
        { property: 'og:site_name', content: this.$store.state.siteName },
        { property: 'og:url', content: this.getCurrentAddress() },
        { property: 'og:image', content: '/img/social.png' },
        { property: 'og:locale', content: 'fr_FR' },

        { name: 'twitter:card', content: 'summary' },
        { name: 'twitter:title', content: this.metaTitle },
        { name: 'twitter:site', content: 'Skyost' },
        { name: 'twitter:creator', content: 'Skyost' },
        { name: 'twitter:description', content: this.description ?? this.metaDescription },
        { name: 'twitter:url', content: this.getCurrentAddress() },
        { name: 'twitter:image', content: '/img/social.png' }
      ],
      link: [
        { rel: 'canonical', href: this.$route.path }
      ]
    }
  },
  mounted () {
    const info = this.$meta().refresh().metaInfo
    this.metaTitle = info.title
    this.metaDescription = info.meta.find(tag => tag.name === 'description').content
  }
}
</script>
