<template>
  <div>
    <social-head :title="title" />

    <page-header>
      <carousel />
    </page-header>

    <page-content>
      <b-container fluid="" class="pt-5">
        <level-list />
      </b-container>
    </page-content>
  </div>
</template>

<script>
import PageHeader from '../components/PageHeader'
import Carousel from '../components/Carousel/Carousel'
import PageContent from '../components/PageContent'
import LevelList from '../components/List/LevelList'
import SocialHead from '../components/SocialHead'
export default {
  components: { SocialHead, LevelList, PageContent, Carousel, PageHeader },
  data () {
    return {
      title: 'Liste des cours'
    }
  },
  head () {
    return {
      title: this.buildBrowserTitle(this.title)
    }
  }
}
</script>

<router>
  path: /cours/
</router>
