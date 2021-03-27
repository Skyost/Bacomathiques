<template>
  <article id="page-content" class="pb-5">
    <slot />
  </article>
</template>

<script>
export default {
  name: 'PageContent'
}
</script>

<style lang="scss">
@import 'assets/colors';

#page-content {
  color: $page-text;

  h1,
  h2,
  h3,
  h4,
  h5 {
    font-family: 'FuturaBT-Medium', sans-serif;
  }

  h2 {
    font-size: 3.25rem;
  }

  a {
    color: darken($main-color, 10%);
    text-decoration: underline;
    text-decoration-color: lighten($main-color, 25%);

    &:hover,
    &:active {
      color: darken($main-color, 20%);
      text-decoration-color: darken($main-color, 20%);
    }

    &.btn,
    &.flat-card-content {
      text-decoration: none;
    }
  }
}
</style>
