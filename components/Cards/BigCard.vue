<script setup lang="ts">
import FlatCard from '~/components/Cards/FlatCard'

withDefaults(defineProps<{
  sal?: string
  blue?: boolean
}>(), {
  sal: undefined,
  blue: false
})
</script>

<template>
  <b-container :fluid="true">
    <b-row
      :data-sal="sal"
      class="justify-content-center"
    >
      <b-col
        cols="12"
        xl="9"
        lg="10"
        class="pr-md-0 pl-md-0"
      >
        <flat-card
          :big="true"
          :blue="blue"
        >
          <slot />
        </flat-card>
      </b-col>
    </b-row>
  </b-container>
</template>
