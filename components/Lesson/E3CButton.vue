<template>
  <b-btn
    v-if="show"
    id="e3c-button"
    v-b-modal.modal-e3c
    class="btn-blue"
  >
    Vous pensez avoir tout compris ?
    <br>Testez-vous sur les <strong>E3C</strong> !
  </b-btn>
</template>

<script>
export default {
  name: 'E3CButton',
  props: {
    lesson: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      show: false
    }
  },
  async fetch () {
    this.show = (await this.$content('e3c')
      .where({
        $and: [
          { 'lessons.level': { $contains: this.lesson.level } },
          { 'lessons.lesson': { $contains: this.lesson.id } }
        ]
      })
      .fetch()).length > 0
  }
}
</script>

<style lang="scss">
@import 'assets/breakpoints';

#e3c-button {
  display: block;
  width: 85%;
  margin-top: 60px;
  margin-left: auto;
  margin-right: auto;
  font-weight: normal !important;

  @media (max-width: $mobile-width) {
    width: 100%;
  }
}
</style>
