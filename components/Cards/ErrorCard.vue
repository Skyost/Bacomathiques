<template>
  <big-card>
    <h2 v-if="errorCode === 404">
      Page non trouvée !
    </h2>
    <h2 v-else>
      Erreur {{ errorCode }}
    </h2>

    <p>
      Vous pouvez continuer votre navigation en allant sur <a href="javascript:history.back()">la page précédente</a>,
      en allant sur <nuxt-link to="/">la page d'accueil</nuxt-link> ou accédant à <nuxt-link to="/cours">l'index des cours</nuxt-link>.
    </p>

    <p v-if="errorCode === 404">
      Si quelque chose devait se trouver ici, n'hésitez pas à
      <nuxt-link to="/a-propos/#contact">me contacter</nuxt-link> pour me le signaler.
    </p>

    <span v-if="errorCode === 404" class="d-block mt-4">
      \[
      \begin{align*}
      \int_{1}^{5} 9x^2 + 2x + 2 \, \mathrm{d}x
      &= \left[ 3x^3 + x^2 + 2x \right]_1^5 \\
      &= \left( 3 \times 5^3 + 5^2 + 2 \times 5 \right) - \left( 3 \times 1^3 + 1^2 + 2 \times 1 \right) \\
      &= \color{red}{404}
      \end{align*}
      \]
    </span>
  </big-card>
</template>

<script>
import BigCard from './BigCard'
import { renderMathJax } from '~/utils/math'

export default {
  name: 'ErrorCard',
  components: { BigCard },
  props: {
    errorCode: {
      type: Number,
      required: true
    }
  },
  mounted () {
    if (this.errorCode === 404) {
      renderMathJax()
    }
  }
}
</script>
