<template>
  <page-content class="pt-5">
    <error-card :error-code="errorCode" />
  </page-content>
</template>

<script>
import PageContent from '../components/PageContent'
import ErrorCard from './Cards/ErrorCard'

export default {
  name: 'PageError',
  components: { PageContent, ErrorCard },
  props: {
    errorCode: {
      type: Number,
      required: true
    }
  }
}
</script>
