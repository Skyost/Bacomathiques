<script setup lang="ts">
defineProps<{
  title: string
  to: string
  button: string
  image: string
}>()
</script>

<template>
  <div class="carousel-item-content">
    <b-row>
      <b-col
        xl="3"
        lg="4"
        md="5"
        cols="12"
        class="offset-xl-3 offset-lg-2 offset-md-1 d-flex align-items-center"
      >
        <img
          :src="image"
          :alt="title"
        >
      </b-col>
      <b-col
        xl="3"
        lg="4"
        md="5"
        cols="12"
        class="d-flex align-items-center"
      >
        <div class="h-100 w-100 d-flex flex-column">
          <h3 v-text="title" />
          <div class="content">
            <slot />
          </div>
          <b-button
            variant="white"
            :to="to"
            class="btn"
          >
            {{ button }}
          </b-button>
        </div>
      </b-col>
    </b-row>
  </div>
</template>

<style lang="scss" scoped>
@import 'assets/bootstrap-mixins';

.carousel-item-content {
  h3 {
    margin-bottom: 15px;

    @include media-breakpoint-down(md) {
      margin-top: 15px;
    }
  }

  .content {
    flex: 1;
    padding-bottom: 15px;
  }

  img {
    width: 100%;

    @include media-breakpoint-down(md) {
      width: initial;
      max-height: 350px;
      display: block;
      margin: auto;
    }
  }

  :deep(.btn) {
    padding: 14px;
    font-weight: bold;
  }

  @include media-breakpoint-down(md) {
    padding: 30px 20px;
    width: calc(100% - 60px);
  }
}
</style>
