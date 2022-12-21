<template>
  <div>
    <page-head title="Liste des cours" />

    <page-header>
      <carousel />
    </page-header>

    <page-content>
      <ski-container :fluid="true" class="pt-5">
        <ski-columns class="pt-5 pb-5 d-flex justify-content-center align-items-lg-stretch align-items-center">
          <card-column
            v-for="level in levels"
            :key="level.id"
            class="mb-5"
            :to="`/cours/${level.id}/`"
            :size="6"
            :blue="true"
          >
            <img class="level-image" :src="level.image" :alt="level.name">
            <h2 v-text="level.name" />
            <p class="mb-0" v-html="level.description" />
          </card-column>
        </ski-columns>
      </ski-container>
    </page-content>
  </div>
</template>

<script>
import PageHeader from '~/components/PageHeader'
import Carousel from '~/components/Carousel/Carousel'
import PageContent from '~/components/PageContent'
import PageHead from '~/components/PageHead'
import CardColumn from '~/components/Cards/CardColumn'
import { levels } from '~/utils/lesson'

export default {
  components: { CardColumn, PageHead, PageContent, Carousel, PageHeader },
  computed: {
    levels () {
      return Object.values(levels)
    }
  }
}
</script>

<style lang="scss" scoped>
.level-image {
  height: 90px;
}
</style>
