<template>
  <footer id="page-footer" class="blue container-fluid">
    <b-row>
      <b-col lg="4" md="12" class="mb-lg-0 mb-5">
        <h3>Créé avec ❤️</h3>

        <p>Ce site web a été fait avec amour par <a href="https://skyost.eu">Hugo Delaunay</a> à l'aide de certaines technologies.</p>
        <p>
          Vous pouvez consulter tout ça et également me contacter sur la page
          <nuxt-link to="/a-propos/">À propos</nuxt-link>.
        </p>
        <p class="mb-0">
          Si vous aimez vraiment ce site web, n'hésitez pas à
          <nuxt-link to="/a-propos/#licence-contributions">y contribuer</nuxt-link>.
        </p>
      </b-col>
      <b-col lg="4" md="6" class="mb-md-0 mb-5">
        <h3>Licence</h3>

        <p>Copyright &copy; 2021 {{ siteName }}. Toute reproduction totale ou partielle est interdite excepté pour un usage pédagogique et non-commercial (en citant explicitement la propriété de {{ siteName }}).</p>
        <p class="mb-0">
          <em><strong>Google Play</strong> et le logo Google Play sont des marques de Google LLC. <strong>App Store</strong> et le logo App Store sont des marques de Apple Inc.</em>
        </p>
      </b-col>
      <b-col lg="4" md="6">
        <h3>Navigation</h3>

        <ul>
          <li>
            <nuxt-link to="/">
              Accueil
            </nuxt-link>
          </li>
          <li>
            <nuxt-link to="/cours/">
              Liste des cours
            </nuxt-link>
          </li>
          <li>
            <nuxt-link to="/a-propos/">
              À propos
            </nuxt-link>
          </li>
        </ul>
      </b-col>
      <b-col
        cols="6"
        xl="3"
        offset-xl="3"
        lg="4"
        offset-lg="2"
        class="col-store"
      >
        <a :href="appStore">
          <img src="/img/stores/app-store.svg" alt="Disponible sur App Store">
        </a>
      </b-col>
      <b-col
        cols="6"
        xl="3"
        lg="4"
        class="col-store"
      >
        <a :href="googlePlay">
          <img src="/img/stores/play-store.svg" alt="Disponible sur Google Play">
        </a>
      </b-col>
    </b-row>
    <hr class="mt-5">
    <p class="mb-0 text-break">
      Copyright &copy; 2021 - {{ siteName }}.
      <br>Généré le {{ buildDate }} à {{ buildTime }}.
    </p>
  </footer>
</template>

<script>
import { APP_STORE, GOOGLE_PLAY, SITE_NAME } from '~/utils/site'

export default {
  name: 'PageFooter',
  data () {
    return {
      siteName: SITE_NAME,
      googlePlay: GOOGLE_PLAY,
      appStore: APP_STORE
    }
  },
  computed: {
    buildDate () {
      const date = new Date()
      return [date.getDate(), date.getMonth() + 1, date.getFullYear()].map(n => n < 10 ? `0${n}` : `${n}`).join('/')
    },
    buildTime () {
      const date = new Date()
      return [date.getHours(), date.getMinutes(), date.getSeconds()].map(n => n < 10 ? `0${n}` : `${n}`).join(':')
    }
  }
}
</script>

<style lang="scss">
@import 'assets/common';
@import 'assets/breakpoints';

#page-footer {
  padding: 40px 140px;

  .col-store {
    text-align: center;
    margin-top: 3rem;

    img {
      width: 90%;
      max-width: 300px;
    }
  }

  @media (max-width: $mobile-width) {
    padding-left: 15px;
    padding-right: 15px;
  }
}
</style>
