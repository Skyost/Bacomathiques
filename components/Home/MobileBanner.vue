<template>
  <b-container fluid="" class="mobile-apps">
    <b-row>
      <b-col cols="12" xl="8" class="text text-center">
        <h2>Besoin de mobilité ?</h2>

        <p class="pl-md-0 pl-3 pr-md-0 pr-3">
          Un petit doute sur un énoncé ?
          <br>Besoin de réviser mais pas envie d'ouvrir les livres de cours ?
          <br>Ou alors vous avez simplement besoin de consulter vos cours sans être connecté à internet ?
        </p>

        <p class="pl-md-0 pl-3 pr-md-0 pr-3">
          L'application <strong>{{ $store.state.siteName }}</strong> est là pour vous !
          Elle est disponible pour Android et iOS via les boutons ci-dessous.
        </p>

        <cards-row sal="slide-up">
          <small-card image="/img/index/stores/app-store.svg" :size="5" :href="$store.state.appStore">
            Disponible sur <strong>App Store</strong>.
          </small-card>
          <small-card image="/img/index/stores/play-store.svg" :size="5" :href="$store.state.googlePlay">
            Disponible sur <strong>Google Play</strong>.
          </small-card>
        </cards-row>
      </b-col>
      <b-col xl="4" class="d-xl-block d-none position-relative">
        <div class="device" data-sal="slide-left">
          <img src="/img/index/app-screenshot.png" alt="Application Bacomathiques" class="w-100">
        </div>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import CardsRow from '../Cards/CardsRow'
import SmallCard from '../Cards/SmallCard'
export default {
  name: 'MobileBanner',
  components: { SmallCard, CardsRow }
}
</script>

<style lang="scss">
@import "assets/breakpoints";
@import "assets/common";
@import "assets/flat_card";

.mobile-apps {
  background: linear-gradient(0deg, transparent 50px, $main-color 50px);
  margin-top: 50px;

  .text {
    padding: 80px 140px 0 140px;

    .flat-cards {
      background: none;

      @media (min-width: $tablet-width) {
        padding: 0;
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

    @media (max-width: $tablet-width) {
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

  @media (max-width: $tablet-width) {
    background: linear-gradient(0deg, transparent 350px, $main-color 350px);
  }
}
</style>
