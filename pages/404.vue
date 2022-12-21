<template>
  <page-error :error="{ statusCode: '404' }" />
</template>

<script>
import PageError from '~/components/PageError'

export default {
  components: { PageError }
}
</script>
