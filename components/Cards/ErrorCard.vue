<script setup lang="ts">
import katex from 'katex'
import BigCard from '~/components/Cards/BigCard.vue'

const props = defineProps<{ error: any }>()

const errorCode = computed<number | null>(() => {
  if (/^-?\d+$/.test(props.error.toString())) {
    return parseInt(props.error.toString())
  }
  if (Object.prototype.hasOwnProperty.call(props.error, 'statusCode')) {
    return parseInt(props.error.statusCode)
  }
  return null
})

const title = computed<string>(() => {
  if (errorCode.value === 404) {
    return 'Page non trouvée !'
  }
  if (errorCode.value) {
    return `Erreur ${errorCode.value}`
  }
  return 'Erreur'
})

const integral = computed<string>(() => {
  return katex.renderToString(`\\begin{align*}
  \\int_1^5 9x^2 + 2x + 2 \\, \\mathrm{d}x &= \\left[ 3x^3 + x^2 + 2x \\right]_1^5 \\\\
  &= (3 \\times 5^3 + 5^2 + 2 \\times 5) - (3 \\times 1^3 + 1^2 + 2 \\times 1) \\\\
  &= \\color{red} 404
\\end{align*}`, { displayMode: true })
})
</script>

<template>
  <big-card>
    <h2>{{ title }}</h2>

    <p>
      Vous pouvez continuer votre navigation en allant sur <a href="javascript:history.back()">la page précédente</a>,
      en allant sur <nuxt-link to="/">
        la page d'accueil
      </nuxt-link> ou accédant à <nuxt-link to="/cours">
        l'index des cours
      </nuxt-link>.
    </p>

    <p v-if="errorCode === 404">
      Si quelque chose devait se trouver ici, n'hésitez pas à
      <nuxt-link to="/a-propos/#contact">
        me contacter
      </nuxt-link> pour me le signaler.
    </p>

    <span
      v-if="errorCode === 404"
      class="d-block mt-4"
    >
      <span v-html="integral" />
    </span>
  </big-card>
</template>
