<template>
  <div>
    <h2 id="licence-contributions">
      Licences &amp; contributions
    </h2>

    <p>
      Les cours ont été écrits intégralement par <a href="https://skyost.eu">Hugo Delaunay</a>,
      Toute reproduction totale ou partielle est interdite excepté pour un usage pédagogique et non-commercial (en citant explicitement la propriété de {{ siteName }}).
      Certaines démonstrations sont tirées de <a href="https://www.sesamath.net/">Sésamath</a>,
      et certaines introductions ont été reprises de <a href="https://fr.wikipedia.org">Wikipédia</a>.
    </p>

    <p>
      Toutes les technologies intégrées dans ce site web sont disponibles sous licence <strong>open-source</strong>.
      N'hésitez pas à aller faire un tour sur leurs pages respectives !
    </p>

    <p>
      Ce site utilise des services tiers tels que Google Analytics et Google AdSense.
      L'application utilise Google AdMob, il vous est donc possible de consulter
      la <nuxt-link to="/pdf/politique-de-confidentialite.pdf">Politique de confidentialité</nuxt-link>.
    </p>

    <hr>

    <p>
      Il existe énormément de moyens de <strong>contribuer</strong> au projet {{ siteName }} !
      Vous pouvez y faire des modifications ou même tout simplement lui donner une étoile sur
      <a :href="github">Github</a>.
      Il vous est également possible d'effectuer des dons, que ce soit directement
      via <a href="https://paypal.me/Skyost">PayPal</a> ou en regardant des publicités sur
      <a href="https://utip.io/skyost">uTip</a>.
    </p>

    <p>
      Par ailleurs, les contributions sont facultatives et vous pouvez pleinement profiter
      de {{ siteName }} sans aucune action de votre part. Sachez cependant que les contributions sont
      très appréciées. 😉
    </p>
  </div>
</template>

<script>
import { GITHUB, SITE_NAME } from '~/utils/site'

export default {
  name: 'LicenseContributions',
  data () {
    return {
      siteName: SITE_NAME,
      github: GITHUB
    }
  }
}
</script>
