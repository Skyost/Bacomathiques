<script setup lang="ts">
import PageNavbar from '~/components/Page/Navbar/PageNavbar.vue'
import PageFooter from '~/components/Page/PageFooter.vue'
</script>

<template>
  <div>
    <nuxt-loading-indicator color="#f2f4f6" />
    <page-navbar />
    <slot />
    <page-footer />
  </div>
</template>

<style lang="scss">
@import 'assets/bootstrap-mixins';
@import 'assets/colors';

// TODO: https://www.reddit.com/r/webdev/comments/wdsctt/if_your_website_is_dark_by_default_consider/

.container-fluid {
  padding: 0 100px;

  @include media-breakpoint-down(lg) {
    padding-left: 40px;
    padding-right: 40px;
  }

  @include media-breakpoint-down(md) {
    padding-left: 15px;
    padding-right: 15px;
  }
}

form label {
  display: none;
}

::-webkit-scrollbar {
  width: 6px;
  height: 6px;
}

::-webkit-scrollbar-button {
  width: 0;
  height: 0;
}

::-webkit-scrollbar-track {
  $scrollbar-track-background: transparent;
  $scrollbar-track-background-active: transparent;
  $scrollbar-track-border: white;

  background-color: $scrollbar-track-background;
  border: 0 none $scrollbar-track-border;
  border-radius: 0;

  &:active {
    background-color: $scrollbar-track-background-active;
  }
}

/* stylelint-disable */
::-webkit-scrollbar-corner {
  background-color: transparent;
}

::-webkit-scrollbar-thumb {
  $scrollbar-thumb-background: #999;
  $scrollbar-thumb-background-hover: #777;
  $scrollbar-thumb-background-active: #424242;
  $scrollbar-thumb-border: white;

  background-color: $scrollbar-thumb-background;
  border: 0 none $scrollbar-thumb-border;
  border-radius: 0;

  &:hover {
    background-color: $scrollbar-thumb-background-hover;
  }

  &:active {
    background-color: $scrollbar-thumb-background-active;
  }
}
/* stylelint-enable */
</style>
