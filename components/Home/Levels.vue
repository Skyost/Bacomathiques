<template>
  <section>
    <h2>Convaincu ?</h2>

    <p class="mb-5">
      Alors sélectionnez votre classe et découvrez sans plus attendre les cours qui y sont rattachés !
    </p>

    <b-row class="card-levels mb-5">
      <b-col
        v-for="(level, index) in levels"
        :key="level.id"
        cols="12"
        :lg="12 / levels.length"
        class="mb-lg-0"
        :class="{'mb-3': index !== levels.length}"
      >
        <b-btn variant="white" class="card-level-button" :to="`/cours/${ level.id }/`">
          <img :src="level.image" :alt="level.name"> {{ level.name }}
        </b-btn>
      </b-col>
    </b-row>

    <p class="mb-0">
      <em>Les cours pour Terminale option maths complémentaires arrivent bientôt !</em>
    </p>
  </section>
</template>

<script>
export default {
  name: 'Levels',
  data () {
    return {
      levels: []
    }
  },
  async fetch () {
    this.levels = await this.$content('levels').sortBy('order').fetch()
  }
}
</script>

<style lang="scss">
@import 'assets/flat_card';

.card-levels {
  .card-level-button {
    height: 100%;
    width: 100%;
    padding: 30px;

    img {
      display: block;
      margin: 0 auto 5px auto;
      width: 80px;
    }
  }
}
</style>
