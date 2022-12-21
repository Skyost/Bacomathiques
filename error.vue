<template>
  <NuxtLayout>
    <page-head :title="`Erreur ${error.statusCode}`" />
    <page-error :error-code="error.statusCode.toString()" />
  </NuxtLayout>
</template>

<script>
import PageError from '~/components/PageError'

export default {
  components: { PageError },
  props: {
    error: {
      type: Object,
      required: true
    }
  }
}
</script>
