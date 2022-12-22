<template>
  <path :d="d" />
</template>

<script>
export default {
  props: {
    d: {
      type: String,
      required: true
    }
  }
}
</script>
