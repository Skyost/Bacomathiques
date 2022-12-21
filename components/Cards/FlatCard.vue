<template>
  <div class="flat-card">
    <div class="flat-card-content h-100" :class="{'big-flat-card-content': big, 'blue': blue}">
      <img v-if="image" class="flat-card-image" :src="image" :alt="image">
      <slot />
    </div>
  </div>
</template>

<script>
export default {
  props: {
    big: {
      type: Boolean,
      default: false
    },
    blue: {
      type: Boolean,
      default: false
    },
    image: {
      type: String,
      default: null
    }
  }
}
</script>

<style lang="scss" scoped>
@import 'assets/colors.scss';
@import 'assets/bootstrap-mixins.scss';

.flat-card {
  .flat-card-content {
    display: block;
    font-weight: normal;
    text-align: center;
    margin: 0 8px;
    color: $body-color;
    background-color: white;
    box-shadow: 0 0 30px rgba(black, 0.2);
    transition: background-color 200ms;
    padding: 30px 20px;

    .flat-card-image {
      display: block;
      margin-left: auto;
      margin-right: auto;
      height: 90px;
      margin-bottom: 20px;
    }

    &.big-flat-card-content {
      padding: 80px 140px;

      @include media-breakpoint-down(lg) {
        padding: 50px 40px;
      }

      @include media-breakpoint-down(md) {
        padding: 30px 20px;
      }
    }

    &:hover {
      background-color: #f5f5f5;
    }

    &.blue:hover {
      background-color: darken($primary, 3%) !important;
    }

    form {
      text-align: left;
    }
  }

  a.flat-card-content:not(.blue) {
    color: $body-color !important;
  }
}
</style>
