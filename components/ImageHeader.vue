<script setup lang="ts">
defineProps<{
  image: string
}>()

const slots = useSlots()
</script>

<template>
  <b-row class="ms-0 me-0">
    <b-col
      width="12"
      xl="2"
      lg="3"
      md="3"
      class="mb-4 mb-md-0 d-flex align-items-center offset-xl-3 offset-lg-2 offset-md-1"
    >
      <slot
        v-if="slots.image"
        name="image"
      />
      <img
        v-else
        class="header-image ms-auto me-auto ms-md-0 me-md-0"
        :src="image"
        alt="En-tête"
      >
    </b-col>
    <b-col
      width="12"
      xl="4"
      lg="5"
      md="7"
      class="d-flex align-items-center"
    >
      <div class="w-100">
        <slot />
      </div>
    </b-col>
  </b-row>
</template>

<style lang="scss" scoped>
@import 'assets/bootstrap-mixins';

.header-image {
  max-width: 200px;
  width: 100%;

  @include media-breakpoint-down(md) {
    max-width: 150px;
  }
}
</style>
