<template>
  <section>
    <h2>Convaincu ?</h2>

    <p class="mb-5">
      Alors sélectionnez votre classe et découvrez sans plus attendre les cours qui y sont rattachés !
    </p>

    <ski-columns class="card-levels mb-5">
      <ski-column
        v-for="(level, index) in levels"
        :key="level.id"
        width="12"
        :lg="(12 / levels.length).toString()"
        class="mb-lg-0"
        :class="{'mb-3': index !== levels.length}"
      >
        <ski-button variant="white" class="card-level-button" :to="`/cours/${ level.id }/`">
          <img :src="level.image" :alt="level.name"> {{ level.name }}
        </ski-button>
      </ski-column>
    </ski-columns>

    <p class="mb-0">
      <em>Les cours pour Terminale option maths complémentaires arrivent bientôt !</em>
    </p>
  </section>
</template>

<script>
import { levels } from '~/utils/lesson'

export default {
  computed: {
    levels () {
      return Object.values(levels)
    }
  }
}
</script>

<style lang="scss">
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
