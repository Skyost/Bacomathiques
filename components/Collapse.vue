<script setup lang="ts">
defineProps<{ id: string, variant: string, buttonClass: string }>()

const isExpanded = ref<boolean>(false)
</script>

<template>
  <div>
    <b-button
      :variant="variant"
      :class="buttonClass"
      @click="isExpanded = !isExpanded"
    >
      <span v-if="isExpanded">&blacktriangledown;</span>
      <span v-else>&blacktriangleright;</span>
      <slot name="button" />
    </b-button>
    <b-collapse
      :id="id"
      v-model="isExpanded"
    >
      <slot />
    </b-collapse>
  </div>
</template>
