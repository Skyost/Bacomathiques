<script setup lang="ts">
import { site } from '~/site/site'

const year = (new Date()).getFullYear()
</script>

<template>
  <footer
    id="page-footer"
    class="blue container-fluid"
  >
    <b-row>
      <b-col
        lg="4"
        md="12"
        class="mb-lg-0 mb-5"
      >
        <h3>Créé avec ❤️</h3>

        <p>Ce site web a été fait avec amour par <a href="https://skyost.eu">Hugo Delaunay</a> à l'aide de certaines technologies.</p>
        <p>
          Vous pouvez consulter tout ça et également me contacter sur la page
          <nuxt-link to="/a-propos/">
            À propos
          </nuxt-link>.
        </p>
        <p class="mb-0">
          Si vous aimez vraiment ce site web, n'hésitez pas à
          <nuxt-link to="/a-propos/#licence-contributions">
            y contribuer
          </nuxt-link>.
        </p>
      </b-col>
      <b-col
        lg="4"
        md="6"
        class="mb-md-0 mb-5"
      >
        <h3>Licence</h3>

        <p>Copyright &copy; {{ year }} {{ site.name }}. Toute reproduction totale ou partielle est interdite excepté pour un usage pédagogique et non commercial.</p>
        <p class="mb-0">
          <em><strong>Google Play</strong> et le logo Google Play sont des marques de Google LLC. <strong>App Store</strong> et le logo App Store sont des marques de Apple Inc.</em>
        </p>
      </b-col>
      <b-col
        lg="4"
        md="6"
      >
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
    </b-row>
    <b-row class="stores">
      <b-col
        cols="6"
        xl="3"
        lg="4"
      >
        <a :href="site.mobile.appStore">
          <img
            src="/img/stores/app-store.svg"
            alt="Disponible sur App Store"
          >
        </a>
      </b-col>
      <b-col
        cols="6"
        xl="3"
        lg="4"
      >
        <a :href="site.mobile.googlePlay">
          <img
            src="/img/stores/play-store.svg"
            alt="Disponible sur Google Play"
          >
        </a>
      </b-col>
    </b-row>
    <hr class="mt-5">
    <p class="mb-0 text-break">
      Copyright &copy; {{ year }} - {{ site.name }}.
      <current-commit-sha />
    </p>
  </footer>
</template>

<style lang="scss" scoped>
@import 'assets/bootstrap-mixins';

#page-footer {
  padding: 40px 140px;

  .stores {
    justify-content: center;
    margin-top: 3rem;

    img {
      width: 90%;
      max-width: 300px;
    }
  }

  @include media-breakpoint-down(md) {
    padding-left: 15px;
    padding-right: 15px;
  }
}
</style>
