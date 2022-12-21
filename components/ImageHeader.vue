<template>
  <ski-columns class="ms-0 me-0">
    <ski-column
      width="12"
      xl="2"
      lg="3"
      md="3"
      class="mb-4 mb-md-0 d-flex align-items-center offset-xl-3 offset-lg-2 offset-md-1"
    >
      <span v-if="background" class="header-image ms-auto me-auto ms-md-0 me-md-0" :style="`background-image: url('${image}');`" />
      <img v-else class="header-image ms-auto me-auto ms-md-0 me-md-0" :src="image" alt="En-tête">
    </ski-column>
    <ski-column width="12" xl="4" lg="5" md="7" class="d-flex align-items-center">
      <div class="w-100">
        <slot />
      </div>
    </ski-column>
  </ski-columns>
</template>

<script>
export default {
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
@import 'assets/bootstrap-mixins';

.header-image {
  max-width: 200px;
  width: 100%;

  @include media-breakpoint-down(md) {
    max-width: 150px;
  }
}
</style>
