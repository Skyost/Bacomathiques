<template>
  <b-container fluid="">
    <b-row :data-sal="sal" class="justify-content-center">
      <b-col cols="12" xl="9" lg="10" class="flat-card pr-md-0 pl-md-0">
        <div class="flat-card-content big-flat-card-content" :class="{'blue': blue}">
          <slot />
        </div>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
export default {
  name: 'BigCard',
  props: {
    sal: {
      type: String,
      default: null
    },
    blue: {
      type: Boolean,
      default: false
    }
  }
}
</script>

<style lang="scss">
@import "assets/common";
@import "assets/flat_card";
</style>
