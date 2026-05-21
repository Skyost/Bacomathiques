<script setup lang="ts">
const props = defineProps<{ error: any }>()

const title = computed(() => {
  let result = 'Erreur'
  if ((Object.hasOwnProperty.call(props.error, 'statusCode'))) {
    result += ` ${props.error.statusCode}`
  }
  return result
})

// onMounted(() => console.error(props.error))
</script>

<template>
  <nuxt-layout>
    <page-head :title="title" />
    <page-error :error="error" />
  </nuxt-layout>
</template>
