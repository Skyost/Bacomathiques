<script setup lang="ts">
import PageContent from '~/components/Page/PageContent.vue'
import PageLoading from '~/components/Page/PageLoading.vue'
import PageHeader from '~/components/Page/PageHeader.vue'
import PageHead from '~/components/Page/PageHead.vue'
import PageError from '~/components/Page/PageError.vue'
import LessonCard from '~/components/Cards/LessonCard.vue'
import { levels } from '~/site/site'

const route = useRoute()
const routeParam = (param: string | string[] | undefined) => Array.isArray(param) ? param[0] : param
const levelParam = routeParam(route.params.level)
const level = levelParam ? levels[levelParam] : undefined

const { pending, data } = useLazyAsyncData(
  route.path,
  () => queryCollection('lessons')
    .where('level', '=', levelParam ?? '')
    .order('chapter', 'ASC')
    .all()
)
</script>

<template>
  <div v-if="level && (pending || data)">
    <page-head :title="`Liste des cours de ${level.name}`" />

    <page-header>
      <image-header :image="level.image">
        <h3 v-text="level.name" />
        <p
          class="mb-0"
          v-html="level.description"
        />
      </image-header>
    </page-header>

    <page-loading v-if="pending" />
    <page-content
      v-else-if="data"
      class="pt-0"
    >
      <cards-row>
        <lesson-card
          v-for="lesson in data"
          :key="lesson.slug"
          class="col-lg-5 col-xl-4 col-12 mb-xl-5"
          :lesson="lesson"
        />
      </cards-row>
    </page-content>
  </div>
  <page-error
    v-else
    error="404"
  />
</template>

<style lang="scss" scoped>
@import '~/assets/bootstrap-mixins';

#page-header {
  padding-bottom: 70px;

  @include media-breakpoint-down(md) {
    padding-bottom: 40px;
  }
}
</style>
