<template>
  <nuxt-link v-if="to" class="logo" :to="to" v-text="siteName" />
  <span v-else class="logo" v-text="siteName" />
</template>

<script>
import { SITE_NAME } from '~/utils/site'

export default {
  name: 'Logo',
  props: {
    to: {
      type: String,
      default: null
    }
  },
  data () {
    return {
      siteName: SITE_NAME
    }
  }
}
</script>

<style lang="scss">
.logo {
  font-family: 'Handlee', cursive;
  color: white !important;
  font-weight: 500;
  text-decoration: none !important;

  &::before {
    content: '';
    display: inline-block;
    vertical-align: -0.12em;
    height: 0.9em;
    width: 0.9em;
    background-size: 0.9em 0.9em;
    background-image: url('/img/logo.svg');
    margin-right: 0.2em;
  }
}
</style>
