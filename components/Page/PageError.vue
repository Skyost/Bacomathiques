<script setup lang="ts">
import ErrorCard from '~/components/Cards/ErrorCard.vue'

defineProps<{ error: any }>()
</script>

<template>
  <page-content class="pt-5">
    <page-head title="Erreur" />
    <error-card :error="error" />
  </page-content>
</template>
