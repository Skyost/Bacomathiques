<template>
  <b-row class="pt-5 pb-5 d-flex justify-content-center align-items-lg-stretch align-items-center">
    <small-card
      v-for="level in levels"
      :key="level.id"
      class="mb-5"
      :href="`/cours/${level.id}/`"
      :image="level.image"
      :size="6"
      blue
    >
      <h2 v-text="level.name" />
      <p class="mb-0" v-html="level.description" />
    </small-card>
  </b-row>
</template>

<script>
import SmallCard from '../Cards/SmallCard'

export default {
  name: 'LevelList',
  components: { SmallCard },
  data () {
    return {
      levels: []
    }
  },
  async fetch () {
    this.levels = await this.$content('levels')
      .sortBy('order')
      .fetch()
  }
}
</script>
