<template>
  <div>
    <b-row class="pr-5 pl-5 pl-md-0 pr-md-0">
      <b-col
        xl="3"
        lg="4"
        md="5"
        cols="12"
        offset-xl="3"
        offset-lg="2"
        offset-md="1"
        class="d-flex align-items-center"
      >
        <img :src="image" class="w-100" :alt="title">
      </b-col>
      <b-col
        xl="3"
        lg="4"
        md="5"
        cols="12"
        class="d-flex align-items-center"
      >
        <div class="w-100">
          <h3 v-text="title" />
          <slot />
          <b-btn variant="white" :to="to" v-text="button" />
        </div>
      </b-col>
    </b-row>
  </div>
</template>

<script>
export default {
  name: 'CarouselItem',
  props: {
    image: {
      type: String,
      required: true
    },
    title: {
      type: String,
      required: true
    },
    to: {
      type: String,
      required: true
    },
    button: {
      type: String,
      required: true
    }
  }
}
</script>
