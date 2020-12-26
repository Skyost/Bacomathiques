<template>
  <div>
    <nav-bar />
    <nuxt />
    <page-footer />
  </div>
</template>

<script>
import NavBar from '../components/NavBar/NavBar'
import PageFooter from '../components/PageFooter'

export default {
  components: { NavBar, PageFooter }
}
</script>

<style lang="scss">
@import "assets/breakpoints";
@import "assets/colors";

.btn {
  font-weight: bold !important;
  border-radius: 0;
  padding: 14px;
  border: 0;

  &.btn-white {
    background-color: white !important;
    color: $main-color !important;

    &:hover,
    &:active {
      background-color: #f5f5f5 !important;
    }
  }

  &.btn-blue {
    background-color: $main-color !important;
    color: white !important;

    &:hover,
    &:active {
      background-color: darken($main-color, 5%) !important;
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
  .modal-content {
    border-radius: 0;

    .b-icon-prefix {
      width: 1em;
    }
  }

  .modal-footer .btn {
    font-weight: normal !important;
  }
}

.container-fluid {
  padding: 0 100px;

  @media (max-width: $tablet-width) {
    padding-left: 40px;
    padding-right: 40px;
  }

  @media (max-width: $mobile-width) {
    padding-left: 15px;
    padding-right: 15px;
  }
}

form {
  label {
    display: none;
  }

  .form-control {
    border-radius: 0 !important;
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
