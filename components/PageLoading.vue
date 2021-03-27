<template>
  <page-content class="pt-5">
    <spring-spinner class="ml-auto mr-auto mt-5 mb-5" />
  </page-content>
</template>

<script>
import SpringSpinner from '../components/SpringSpinner'
import PageContent from '../components/PageContent'

export default {
  name: 'PageLoading',
  components: { SpringSpinner, PageContent }
}
</script>
