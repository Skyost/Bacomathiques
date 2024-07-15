<script setup lang="ts">
import { site } from '~/site/site'
</script>

<template>
  <b-navbar-brand>
    <img
      class="logo"
      src="/img/logo.svg"
      alt="Logo"
    >
    <nuxt-link
      class="brand-link"
      to="/"
    >
      {{ site.name }}
    </nuxt-link>
  </b-navbar-brand>
</template>

<style lang="scss" scoped>
.logo {
  height: 0.9em;
  width: 0.9em;
  vertical-align: -0.12em;
  display: inline-block;
  margin-left: var(--bs-navbar-brand-margin-start);
  margin-right: 0.2em;
}

.brand-link {
  font-family: 'Handlee', cursive;
  font-weight: 500;
  margin-left: 0;
  color: white !important;
  text-decoration: none !important;
}
</style>
