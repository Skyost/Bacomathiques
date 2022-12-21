<script setup>
import { useHead } from 'nuxt/app'

function ensureScriptExecuteOnce (script) {
  return `if (!window.__abg_called){ ${script} window.__abg_called = true;}`
}

useHead({
  script: [
    {
      src: 'https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js',
      async: true
    },
    {
      innerHTML: ensureScriptExecuteOnce('(window.adsbygoogle = window.adsbygoogle || []).push({});')
    }
  ]
})
</script>

<template>
  <ins
    class="adsbygoogle d-block"
    :data-ad-client="clientID"
    data-ad-slot="4882057404"
    data-ad-format="auto"
    data-full-width-responsive="true"
    :data-adtest="test ? 'on' : null"
  />
</template>

<script>
export default {
  computed: {
    test () {
      return process.env.NODE_ENV !== 'production'
    },
    clientID () {
      return this.test ? 'ca-google' : 'ca-pub-7167241518798106'
    }
  }
}
</script>
