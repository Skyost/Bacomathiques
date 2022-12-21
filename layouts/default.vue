<template>
  <div>
    <NuxtLoadingIndicator color="#f2f4f6" />
    <navbar />
    <slot />
    <page-footer />
  </div>
</template>

<script>
import Navbar from '~/components/Navbar/Navbar'
import PageFooter from '~/components/PageFooter'

export default {
  components: { Navbar, PageFooter }
}
</script>

<style lang="scss">
@import 'assets/bootstrap-mixins';
@import 'assets/colors';

// TODO: https://www.reddit.com/r/webdev/comments/wdsctt/if_your_website_is_dark_by_default_consider/

.btn {
  font-weight: bold !important;
  padding: 14px;
  border: 0;

  // TODO: Use Bootstrap themes.
  &.btn-white {
    background-color: white !important;
    color: $primary !important;

    &:hover,
    &:active {
      background-color: #f5f5f5 !important;
    }
  }

  &.btn-blue {
    background-color: $primary !important;
    color: white !important;

    &:hover,
    &:active {
      background-color: darken($primary, 5%) !important;
    }
  }

  &.btn-green {
    $color: #43baa8;

    background-color: $color !important;
    color: white !important;

    &:hover,
    &:active {
      background-color: darken($color, 5%) !important;
    }
  }
}

.modal {
  .modal-content .b-icon-prefix {
    width: 1em;
  }

  .modal-footer .btn {
    font-weight: normal !important;
  }
}

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

form {
  label {
    display: none;
  }
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
