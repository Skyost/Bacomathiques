<script setup lang="ts">
import FlatCard from '~/components/Cards/FlatCard'

withDefaults(defineProps<{
  sal?: string,
  blue?: boolean
}>(), {
  sal: undefined,
  blue: false
})
</script>

<template>
  <ski-container :fluid="true">
    <ski-columns :data-sal="sal" class="justify-content-center">
      <ski-column width="12" xl="9" lg="10" class="pr-md-0 pl-md-0">
        <flat-card :big="true" :blue="blue">
          <slot />
        </flat-card>
      </ski-column>
    </ski-columns>
  </ski-container>
</template>
