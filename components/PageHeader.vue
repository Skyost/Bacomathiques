<template>
  <header id="page-header" class="blue">
    <slot />
  </header>
</template>

<script>
export default {
  name: 'PageHeader'
}
</script>

<style lang="scss">
@import "assets/common";
@import "assets/breakpoints";

#page-header {
  padding: 50px 0;

  .carousel {
    .btn-white {
      width: 100%;
    }

    .slick-dots {
      position: initial;
      padding-top: 10px;

      $size: 12px;
      $bigSize: 30px;

      li {
        height: $size;
        width: $size;
        margin: 0 0.25em;
      }

      li button {
        display: inline-block;
        background-color: #ececec;
        height: $size;
        width: $size;
        border-radius: $size / 2;
        transition: all 200ms;

        &::before {
          content: '';
          height: 0;
        }
      }

      li.slick-active,
      li.slick-active button {
        width: $bigSize;
      }

      li.slick-active button {
        background-color: white;
      }
    }
  }

  @media (max-width: $tablet-width) {
    padding: 30px 0;
  }

  @media (max-width: $mobile-width) {
    padding: 20px 0;
  }
}
</style>
