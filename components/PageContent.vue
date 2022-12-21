<template>
  <article id="page-content" class="pb-5">
    <slot />
  </article>
</template>

<style lang="scss">
@import 'assets/colors';

#page-content {
  h2 {
    font-size: 3.25rem;
  }

  a {
    color: darken($primary, 10%);
    text-decoration: underline;
    text-decoration-color: lighten($primary, 25%);

    &:hover,
    &:active {
      color: darken($primary, 20%);
      text-decoration-color: darken($primary, 20%);
    }

    &.btn,
    &.flat-card-content {
      text-decoration: none;
    }
  }
}
</style>
