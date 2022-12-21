<template>
  <page-content class="pt-5">
    <error-card :error-code="errorCode" />
  </page-content>
</template>

<script>
import PageContent from '~/components/PageContent'
import ErrorCard from '~/components/Cards/ErrorCard'

export default {
  components: { PageContent, ErrorCard },
  props: {
    errorCode: {
      type: String,
      required: true
    }
  }
}
</script>
