<template>
  <div id="page-carousel" class="carousel carousel-dark slide stripes" data-bs-ride="carousel">
    <div class="carousel-indicators">
      <button
        v-for="(slide, index) in slides"
        :key="`carousel-indicator-${index}`"
        type="button"
        data-bs-target="#page-carousel"
        :data-bs-slide-to="index"
        class="carousel-indicator"
        :class="{'active': index === 0}"
        aria-current="true"
        :aria-label="slide.title"
      />
    </div>
    <div class="carousel-inner">
      <div
        v-for="(slide, index) in slides"
        :key="`slide-item-${index}`"
        class="carousel-item"
        :class="{ active: index === 0 }"
        data-bs-interval="5000"
      >
        <carousel-item-content
          class="content"
          :image="slide.image"
          :title="slide.title"
          :href="slide.href"
          :button="slide.button"
        >
          <div v-html="slide.content" />
        </carousel-item-content>
      </div>
    </div>
  </div>
</template>

<script>
import CarouselItemContent from '~/components/Carousel/CarouselItemContent'
import site from '~/site'

export default {
  components: { CarouselItemContent },
  data () {
    return {
      slides: [
        {
          title: `C'est quoi ${site.name} ?`,
          image: '/img/carousel/summary.svg',
          button: 'Accéder à la liste des cours',
          href: '/cours/',
          content: `
            <p>
                <q>Bac-o-math-iques</q> (ou plus simplement <strong>${site.name}</strong>) est un petit site web
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
          title: 'Et bien plus encore !',
          image: '/img/carousel/diploma.svg',
          button: 'Accéder à la liste des cours',
          href: '/cours/',
          content: `
            <p>
                En plus de vous proposer des cours totalement <strong>gratuits</strong> et <strong>libres d'accès</strong>,
                ${site.name} vous permet de les télécharger au format PDF, de les imprimer, de les partager, ...
            </p>
            <p>
                De plus, <em>très bientôt</em>, ${site.name} vous proposera des exercices complets pour vous
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
@import 'assets/bootstrap-mixins';
@import 'assets/colors';

.carousel {
  $paddingBottom: 120px;
  $paddingBottomMd: 100px;
  padding-bottom: $paddingBottom;
  position: relative;

  .btn-white {
    width: 100%;
  }

  .carousel-item .content {
    margin: auto;

    @include media-breakpoint-down(md) {
      padding-bottom: 0;
    }
  }

  .carousel-indicators {
    $indicatorSize: 18px;
    $indicatorBigSize: 70px;
    margin-bottom: calc(($paddingBottom - $indicatorSize) / 2);

    .carousel-indicator {
      display: inline-block;
      background-color: #efefef;
      height: $indicatorSize;
      width: $indicatorSize;
      border-radius: calc($indicatorSize / 2);
      transition: all 200ms;
      opacity: 1;
      border: none;

      &::before {
        content: '';
        height: 0;
      }

      &.active {
        background-color: white;
        width: $indicatorBigSize;
      }
    }

    @include media-breakpoint-down(md) {
      margin-bottom: calc(($paddingBottomMd - $indicatorSize) / 2);
    }
  }

  @include media-breakpoint-down(md) {
    padding: 0 0 $paddingBottomMd 0;
  }
}
</style>
