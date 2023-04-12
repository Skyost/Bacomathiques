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

const runtimeConfig = useRuntimeConfig()
const debug = runtimeConfig.public.debug
</script>

<template>
  <ins
    class="adsbygoogle d-block"
    :data-ad-client="debug ? 'ca-google' : 'ca-pub-7167241518798106'"
    data-ad-slot="4882057404"
    data-ad-format="auto"
    data-full-width-responsive="true"
    :data-adtest="debug ? 'on' : null"
  />
</template>
