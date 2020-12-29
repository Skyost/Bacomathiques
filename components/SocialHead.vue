<template>
  <span v-if="false" />
</template>

<script>
export default {
  name: 'SocialHead',
  props: {
    title: {
      type: String,
      required: true
    },
    description: {
      type: String,
      default: 'Bacomathiques est un petit site web qui contient tout ce dont vous avez besoin pour réviser vos maths en toute tranquillité de la Première à la Terminale ! Que vous cherchiez à passer votre Baccalauréat ou que vous souhaitiez simplement réviser votre cours ; tout est possible et tout est gratuit. Au programme : cours de mathématiques gratuits, téléchargeables et imprimables, annales et corrigés des sujets précédents, etc.'
    }
  },
  head () {
    return {
      meta: [
        {
          property: 'og:title',
          content: this.buildBrowserTitle(this.title)
        },
        {
          property: 'og:description',
          content: this.description
        },
        {
          property: 'og:type',
          content: 'website'
        },
        {
          property: 'og:site_name',
          content: this.$store.state.siteName
        },
        {
          property: 'og:url',
          content: this.getCurrentAddress()
        },
        {
          property: 'og:image',
          content: '/img/social.png'
        },
        {
          property: 'og:locale',
          content: 'fr_FR'
        },

        {
          name: 'twitter:card',
          content: 'summary'
        },
        {
          name: 'twitter:title',
          content: this.buildBrowserTitle(this.title)
        },
        {
          name: 'twitter:description',
          content: this.description
        },
        {
          name: 'twitter:site',
          content: 'Skyost'
        },
        {
          name: 'twitter:creator',
          content: 'Skyost'
        },
        {
          name: 'twitter:url',
          content: this.getCurrentAddress()
        },
        {
          name: 'twitter:image',
          content: '/img/social.png'
        }
      ],
      link: [
        {
          rel: 'canonical',
          href: this.$route.path
        }
      ]
    }
  }
}
</script>
