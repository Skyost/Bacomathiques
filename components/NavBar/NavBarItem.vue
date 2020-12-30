<template>
  <b-nav-item :to="to" :active="$nuxt.$route.path === to">
    <slot />
  </b-nav-item>
</template>

<script>
export default {
  name: 'NavBarItem',
  props: {
    to: {
      type: String,
      default: null
    }
  }
}
</script>
