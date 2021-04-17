<template>
  <transition name="fade">
    <div v-if="currentReview" class="review">
      <span class="rating">
        <b-icon-star-fill v-for="index in currentReview.rating" :key="`star-fill-${index}`" /><b-icon-star v-for="index in 5 - currentReview.rating" :key="`star-${index}`" />
      </span>
      <q class="content" v-html="currentReview.message" />
      <span class="author">
        {{ currentReview.author }}, {{ currentReview.date }} sur
        <span v-if="currentReview.source === 0">
          <a :href="googlePlay">Google Play</a>.
        </span>
        <span v-else>
          l'<a :href="appStore">App Store</a>.
        </span>
      </span>
    </div>
  </transition>
</template>

<script>
import { BIconStar, BIconStarFill } from 'bootstrap-vue'
import { APP_STORE, GOOGLE_PLAY } from '~/utils/site'
import { sleeper } from '~/utils/utils'

export default {
  name: 'Reviews',
  components: { BIconStarFill, BIconStar },
  data () {
    return {
      currentReviewIndex: false,
      currentReview: null,
      googlePlay: GOOGLE_PLAY,
      appStore: APP_STORE,
      reviews: [
        {
          author: 'Linasa',
          date: '23 sept. 2018',
          message: 'Très belle application, <strong>contenu synthétique</strong> et bien expliqué, devs au top 🙂',
          rating: 5,
          source: 0
        },
        {
          author: 'F. Chibaco',
          date: '15 août 2019',
          message: 'Merci beaucoup, cette appli est <strong>très bien expliquée</strong>. Merci encore. Et ça mérite plus de 5 étoiles.',
          rating: 5,
          source: 0
        },
        {
          author: 'L. Saez',
          date: '28 sept. 2019',
          message: 'Des développeurs <strong>à l\'écoute</strong> qui prennent en compte les commentaires, je mets donc 5 étoiles.',
          rating: 5,
          source: 0
        },
        {
          author: 'D. Mendes',
          date: '8 oct. 2019',
          message: 'Franchement <strong>merci</strong>, vous aidez beaucoup de monde.',
          rating: 5,
          source: 0
        },
        {
          author: 'M. Daffe',
          date: '13 nov. 2019',
          message: 'L\'application est bonne car <strong>tout est détaillé</strong> avec des exemples précis, ça mérite plus que 5 étoiles.',
          rating: 5,
          source: 0
        },
        {
          author: 'Ilyes',
          date: '10 fev. 2020',
          message: '<strong>J\'adore</strong> cette application ! Elle m\'aide beaucoup à réviser avant mes devoirs. Merci !',
          rating: 5,
          source: 0
        },
        {
          author: 'A. Lamah',
          date: '13 fev. 2020',
          message: 'Très bon merci beaucoup, <strong>cela m\'a beaucoup aidé</strong> à former mes enfants. Félicitations au développeur.',
          rating: 4,
          source: 0
        },
        {
          author: 'F. Calvez',
          date: '24 fev. 2020',
          message: '<strong>Très bonne application.</strong> Bravo au développeur.',
          rating: 5,
          source: 0
        },
        {
          author: 'F. Calvez',
          date: '24 fev. 2020',
          message: '<strong>Très bonne application.</strong> Bravo au développeur.',
          rating: 5,
          source: 0
        },
        {
          author: 'R. Belgique',
          date: '7 avr. 2020',
          message: '<strong>Vraiment super.</strong> Merci.',
          rating: 5,
          source: 0
        },
        {
          author: 'S. Simon',
          date: '3 juin 2020',
          message: "<strong>J'adore</strong> cette appli. Je suis en terminale, j'ai 17 ans et je suis fan ; elle est parfaite sur le cours, les leçons, etc...",
          rating: 5,
          source: 0
        },
        {
          author: 'M. Toure',
          date: '9 août 2020',
          message: 'Très cool l\'application ✌',
          rating: 5,
          source: 0
        },
        {
          author: 'J. Bleza',
          date: '1 sept. 2020',
          message: 'J\'aime <strong>beaucoup</strong> cette application !',
          rating: 5,
          source: 0
        },
        {
          author: 'I. Martins',
          date: '17 nov. 2020',
          message: 'Cette application m\'est <strong>très utile</strong> lors des révisions et pour faire mes fiches !',
          rating: 5,
          source: 0
        },
        {
          author: 'R. Akoma',
          date: '4 dec. 2020',
          message: 'Tout simplement <strong>très utile</strong>. Merci beaucoup.',
          rating: 5,
          source: 0
        },
        {
          author: 'TheLéna',
          date: '4 janv. 2021',
          message: 'Bonne application qui permet d’avoir un cours d’un point de vue différent. <strong>Je recommande</strong>.',
          rating: 5,
          source: 0
        }
      ]
    }
  },
  mounted () {
    this.$nextTick(this.pickRandom)
  },
  methods: {
    async pickRandom () {
      this.currentReview = null
      await sleeper(300)
      let index
      do {
        index = Math.floor(Math.random() * this.reviews.length)
      }
      while (index === this.currentReviewIndex)
      this.currentReviewIndex = index
      this.currentReview = this.reviews[index]
      setTimeout(() => this.pickRandom(), 5000)
    }
  }
}
</script>

<style lang="scss">
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s;
}

.fade-enter,
.fade-leave-to {
  opacity: 0;
}

.review {
  .rating {
    display: block;
    color: #f1c40f;
    font-size: 50px;
    margin-bottom: 40px;

    .b-icon:nth-child(1),
    .b-icon:nth-child(5) {
      vertical-align: -0.4em;
    }

    .b-icon:nth-child(2),
    .b-icon:nth-child(4) {
      vertical-align: -0.2em;
    }
  }

  .content {
    display: block;
    margin-bottom: 10px;
  }
}
</style>
