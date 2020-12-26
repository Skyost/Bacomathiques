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
  name: 'AdByGoogle',
  head () {
    return {
      script: [
        {
          hid: 'adsbygoogle',
          src: 'https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js',
          async: true
        },
        {
          hid: 'adsbygoogle-load',
          innerHTML: this.ensureScriptExecuteOnce('(window.adsbygoogle = window.adsbygoogle || []).push({});')
        }
      ]
    }
  },
  computed: {
    test () {
      return process.env.NODE_ENV !== 'production'
    },
    clientID () {
      return this.test ? 'ca-google' : 'ca-pub-7167241518798106'
    }
  },
  methods: {
    ensureScriptExecuteOnce (script) {
      return `if (!window.__abg_called){ ${script} window.__abg_called = true;}`
    }
  }
}
</script>
