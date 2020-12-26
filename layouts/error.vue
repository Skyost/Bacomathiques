<template>
  <page-content class="pt-5">
    <big-card>
      <h2 v-if="error.statusCode === 404">
        Page non trouvée !
      </h2>
      <h2 v-else>
        Erreur <span v-text="error.statusCode" />
      </h2>

      <p>
        Vous pouvez continuer votre navigation en allant sur <a href="javascript:history.back()">la page précédente</a>,
        en allant sur
        <nuxt-link to="/">
          la page d'accueil
        </nuxt-link>
        ou accédant à
        <nuxt-link to="/cours">
          l'index des cours
        </nuxt-link>.
      </p>

      <p v-if="error.statusCode === 404">
        Si quelque chose devait se trouver ici, n'hésitez pas à
        <nuxt-link to="/a-propos/#contact">
          me contacter
        </nuxt-link>
        pour me le signaler.
      </p>

      <span v-if="error.statusCode === 404" class="d-block mt-4">
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
  </page-content>
</template>

<script>
import BigCard from '../components/Cards/BigCard'
import PageContent from '../components/PageContent'
export default {
  components: { PageContent, BigCard },
  layout: 'error',
  props: {
    error: {
      type: Object,
      default: null
    }
  },
  head () {
    return {
      title: this.buildBrowserTitle(`Erreur ${this.error.statusCode}`)
    }
  },
  mounted () {
    console.error(this.error)
    if (this.error.statusCode === 404) {
      this.renderMathJax()
    }
  }
}
</script>
