<template>
  <path :d="d" />
</template>

<script>
export default {
  name: 'SvgPath',
  props: {
    d: {
      type: String,
      required: true
    }
  }
}
</script>
