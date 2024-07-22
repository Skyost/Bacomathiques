<script setup lang="ts">
import PageHeader from '~/components/Page/PageHeader.vue'
import Carousel from '~/components/Page/Carousel/Carousel'
import PageContent from '~/components/Page/PageContent.vue'
import PageHead from '~/components/Page/PageHead.vue'
import CardColumn from '~/components/Cards/CardColumn'
import { levels } from '~/site/site'

const levelObjects = Object.values(levels)
</script>

<template>
  <div>
    <page-head title="Liste des cours" />

    <page-header>
      <carousel />
    </page-header>

    <page-content>
      <b-container
        :fluid="true"
        class="pt-5"
      >
        <b-row class="pt-5 pb-5 d-flex justify-content-center align-items-lg-stretch align-items-center">
          <card-column
            v-for="level in levelObjects"
            :key="level.id"
            class="mb-5"
            :to="`/cours/${level.id}/`"
            :size="6"
            :blue="true"
          >
            <img
              class="level-image"
              :src="level.image"
              :alt="level.name"
            >
            <h2 v-text="level.name" />
            <p
              class="mb-0"
              v-html="level.description"
            />
          </card-column>
        </b-row>
      </b-container>
    </page-content>
  </div>
</template>

<style lang="scss" scoped>
.level-image {
  height: 90px;
}
</style>
