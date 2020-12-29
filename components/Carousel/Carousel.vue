<template>
  <vue-slick-carousel
    class="carousel"
    :arrows="false"
    :autoplay="true"
    :autoplay-speed="5000"
    :dots="true"
    :pause-on-focus="false"
    :pause-on-hover="false"
  >
    <carousel-item
      v-for="slide in slides"
      :key="slide.id"
      :image="slide.image"
      :title="slide.title"
      :to="slide.href"
      :button="slide.button"
    >
      <div v-html="slide.content" />
    </carousel-item>
  </vue-slick-carousel>
</template>

<script>
import VueSlickCarousel from 'vue-slick-carousel'
import 'vue-slick-carousel/dist/vue-slick-carousel.css'
import 'vue-slick-carousel/dist/vue-slick-carousel-theme.css'

import CarouselItem from './CarouselItem'

export default {
  name: 'Carousel',
  components: { VueSlickCarousel, CarouselItem },
  data () {
    return {
      slides: [
        {
          id: 'slide-1',
          title: `C'est quoi ${this.$store.state.siteName} ?`,
          image: '/img/carousel/summary.svg',
          button: 'Accéder à la liste des cours',
          href: '/cours/',
          content: `
            <p>
                <q>Bac-o-math-iques</q> (ou plus simplement <strong>${this.$store.state.siteName}</strong>) est un petit site web
                qui contient tout ce dont vous avez besoin pour réviser vos maths de la Première à la Terminale !
            </p>
            <p>
                Que vous cherchiez à passer votre Baccalauréat ou que vous souhaitiez simplement <strong>réviser votre
                cours</strong> :
                tout est possible et tout est gratuit.
            </p>
          `
        },
        {
          id: 'slide-2',
          title: 'Des cours clairs et précis',
          image: '/img/carousel/example.svg',
          button: 'Exemple de cours',
          href: '/cours/terminale/suites/',
          content: `
            <p>
                Nous mettons un point d'orgue à écrire nos cours de la manière la plus claire et la plus précise possible.
                Tous les résultats énoncés illustrés par des exemples et par des graphiques
                <a href="https://www.geogebra.org/">GeoGebra</a>, et ceux qui ont besoin d'être démontrés le sont.
            </p>
            <p>
                Surtout, n'hésitez pas à aller voir ça de vous-même en cliquant sur le bouton ci-dessous !
            </p>
          `
        },
        {
          id: 'slide-3',
          title: 'Et bien plus encore !',
          image: '/img/carousel/diploma.svg',
          button: 'Accéder à la liste des cours',
          href: '/cours/',
          content: `
            <p>
                En plus de vous proposer des cours totalement <strong>gratuits</strong> et <strong>libres d'accès</strong>,
                ${this.$store.state.siteName} vous permet de les télécharger au format PDF, de les imprimer, de les partager, ...
            </p>
            <p>
                De plus, <em>très bientôt</em>, ${this.$store.state.siteName} vous proposera des exercices complets pour vous
                permettre de vous exercer au mieux sur les différents chapitres !
            </p>
          `
        }
      ]
    }
  }
}
</script>

<style lang="scss">
.carousel {
  .btn-white {
    width: 100%;
  }

  .slick-dots {
    position: initial;
    padding-top: 10px;

    $size: 12px;
    $bigSize: 30px;

    li {
      height: $size;
      width: $size;
      margin: 0 0.25em;
    }

    li button {
      display: inline-block;
      background-color: #ececec;
      height: $size;
      width: $size;
      border-radius: $size / 2;
      transition: all 200ms;

      &::before {
        content: '';
        height: 0;
      }
    }

    li.slick-active,
    li.slick-active button {
      width: $bigSize;
    }

    li.slick-active button {
      background-color: white;
    }
  }
}
</style>
