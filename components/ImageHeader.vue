<template>
  <b-row class="ml-0 mr-0">
    <b-col
      cols="12"
      xl="2"
      lg="3"
      md="3"
      offset-xl="3"
      offset-lg="2"
      offset-md="1"
      class="mb-4 mb-md-0 d-flex align-items-center"
    >
      <span v-if="background" class="header-image ml-auto mr-auto ml-md-0 mr-md-0" :style="`background-image: url('${image}');`" />
      <img v-else class="header-image ml-auto mr-auto ml-md-0 mr-md-0" :src="image" alt="En-tête">
    </b-col>
    <b-col cols="12" xl="4" lg="5" md="7" class="d-flex align-items-center">
      <div class="w-100">
        <slot />
      </div>
    </b-col>
  </b-row>
</template>

<script>
export default {
  name: 'ImageHeader',
  props: {
    background: {
      type: Boolean,
      default: false
    },
    image: {
      type: String,
      required: true
    }
  }
}
</script>

<style lang="scss">
@import "assets/breakpoints";

.header-image {
  max-width: 200px;
  width: 100%;

  @media (max-width: $mobile-width) {
    max-width: 150px;
  }
}
</style>
