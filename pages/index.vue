<script setup lang="ts">
import { site, levels } from '~/site/site'
import Carousel from '~/components/Page/Carousel/Carousel.vue'
import CardColumn from '~/components/Cards/CardColumn.vue'
import BigCard from '~/components/Cards/BigCard.vue'

const featureCards = [
  {
    id: 'book',
    content: 'Des cours en accord avec <strong>les programmes officiels</strong> du ministère de l\'Éducation nationale.'
  },
  {
    id: 'check',
    content: 'Des exemples intuitifs et la possibilité de <strong>télécharger</strong> et <strong>imprimer les cours</strong> gratuitement pour les relire chez soi !'
  },
  {
    id: 'computer',
    content: 'Le plus important : <strong>tout est gratuit</strong>. Même pas besoin de compte, tout est à disposition de tout le monde !'
  }
]

const levelObjects = Object.values(levels)

useSal()
</script>

<template>
  <div>
    <page-head title="Accueil" />

    <page-header>
      <carousel />
    </page-header>

    <page-content>
      <section class="pb-5">
        <cards-row sal="slide-up">
          <card-column
            v-for="card in featureCards"
            :key="card.id"
            class="mb-5"
            :image="`/img/index/features/${card.id}.svg`"
            :size="3"
          >
            <span v-html="card.content" />
          </card-column>
        </cards-row>
      </section>

      <section class="pt-5 pb-5">
        <big-card
          :blue="true"
          sal="slide-right"
        >
          <h2>Convaincu ?</h2>

          <p class="mb-5">
            Alors sélectionnez votre classe et découvrez sans plus attendre les cours qui y sont rattachés !
          </p>

          <b-row class="card-levels mb-5">
            <b-col
              v-for="(level, index) in levelObjects"
              :key="level.id"
              width="12"
              :lg="12 / levelObjects.length"
              class="mb-lg-0"
              :class="{ 'mb-3': index !== levelObjects.length }"
            >
              <b-button
                variant="white"
                class="card-level-button"
                :to="`/cours/${level.id}/`"
              >
                <img
                  :src="level.image"
                  :alt="level.name"
                > {{ level.name }}
              </b-button>
            </b-col>
          </b-row>

          <p class="mb-0">
            <em>Les cours pour Terminale option maths complémentaires arrivent bientôt !</em>
          </p>
        </big-card>
      </section>

      <section class="pt-5 pb-5">
        <b-container
          :fluid="true"
          class="mobile-apps"
        >
          <b-row>
            <b-col
              width="12"
              xl="8"
              class="text text-center"
            >
              <h2>Besoin de mobilité ?</h2>

              <p class="pl-md-0 pl-3 pr-md-0 pr-3">
                Un petit doute sur un énoncé ?
                <br>Besoin de réviser mais pas envie d'ouvrir les livres de cours ?
                <br>Ou alors vous avez simplement besoin de consulter vos cours sans être connecté à internet ?
              </p>

              <p class="pl-md-0 pl-3 pr-md-0 pr-3">
                L'application <strong>{{ site.name }}</strong> est là pour vous !
                Elle est disponible pour Android et iOS via les boutons ci-dessous.
              </p>

              <cards-row sal="slide-up">
                <card-column
                  image="/img/index/stores/app-store.svg"
                  class="mb-5"
                  :size="5"
                  :to="site.mobile.appStore"
                >
                  Disponible sur <strong>App Store</strong>.
                </card-column>
                <card-column
                  image="/img/index/stores/play-store.svg"
                  class="mb-5"
                  :size="5"
                  :to="site.mobile.googlePlay"
                >
                  Disponible sur <strong>Google Play</strong>.
                </card-column>
              </cards-row>
            </b-col>
            <b-col
              xl="4"
              class="d-xl-block d-none position-relative"
            >
              <div
                class="device"
                data-sal="slide-left"
              >
                <img
                  src="/img/index/app-screenshot.png"
                  alt="Application Bacomathiques"
                  class="w-100"
                >
              </div>
            </b-col>
          </b-row>
        </b-container>
      </section>

      <section class="pt-5 pb-5">
        <big-card sal="zoom-out">
          <reviews />
        </big-card>
      </section>
    </page-content>
  </div>
</template>

<style lang="scss" scoped>
@import 'assets/bootstrap-mixins';
@import 'assets/colors';

.mobile-apps {
  background: linear-gradient(0deg, transparent 50px, $primary 50px);
  margin-top: 50px;

  .text {
    padding: 80px 140px 0 140px;

    .flat-cards {
      background: none;

      @include media-breakpoint-up(lg) {
        padding: 0 !important;
      }
    }

    > h2 {
      color: white;
    }

    > p {
      color: rgba(white, 0.8);
    }

    > p:last-of-type {
      margin-bottom: 80px;
    }

    @include media-breakpoint-down(lg) {
      padding: 80px 0 0 0;
    }
  }

  .device {
    position: absolute;
    top: -10%;
    width: 80%;
    padding: 12% 3%;
    border-radius: 20px;
    box-sizing: border-box;
    background: #fff;
    box-shadow:
      inset 0 4px 7px 1px #fff,
      inset 0 -5px 20px rgba(173, 186, 204, 0.25),
      0 2px 6px rgba(0, 21, 64, 0.14),
      0 10px 20px rgba(0, 21, 64, 0.05);

    &::before,
    &::after {
      content: "";
      display: block;
      position: absolute;
      background: white;
      box-shadow:
        inset 0 4px 7px 1px white,
        inset 0 -5px 20px rgba(173, 186, 204, 0.25),
        0 2px 6px rgba(0, 21, 64, 0.14),
        0 10px 20px rgba(0, 21, 64, 0.05);
    }

    &::after {
      border-radius: 50%;
      margin: 0 auto 2%;
      left: 0;
      right: 0;
      bottom: 0;
      width: 10%;
      height: 0;
      padding-top: 10%;
      box-shadow: inset 0 0 5px 1px rgba(black, 0.12);
    }

    &::before {
      border-radius: 50px;
      margin: 5.5% auto 0;
      left: 0;
      right: 0;
      top: 0;
      width: 20%;
      height: 1%;
      box-shadow: inset 0 0 3px 1px rgba(black, 0.12);
    }

    img {
      width: 100%;
      border-radius: 4px;
      border: 1px solid rgba(black, 0.24);
    }
  }

  @include media-breakpoint-down(lg) {
    background: linear-gradient(0deg, transparent 350px, $primary 350px);
  }
}

.card-levels :deep(.card-level-button) {
  height: 100%;
  padding: 30px;
  width: 100%;
  font-weight: bold;

  img {
    display: block;
    margin: 0 auto 5px;
    width: 80px;
  }
}
</style>
