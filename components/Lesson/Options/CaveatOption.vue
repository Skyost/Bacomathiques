<script setup lang="ts">
import { site } from '~/site/site'
import LessonHeaderOption from '~/components/Lesson/Options/LessonHeaderOption.vue'
import type { Lesson } from '~/types'

defineProps<{ lesson: Lesson }>()

const githubRepo = `https://github.com/${site.github.username}/${site.github.repository}`
</script>

<template>
  <div class="d-inline-block">
    <lesson-header-option
      id="caveat"
      data-bs-toggle="modal"
      data-bs-target="#modal-caveat"
      title="Signaler une erreur"
    />
    <ski-modal id="modal-caveat" title="Signaler une erreur" size="lg" close-button="Fermer">
      <p>Pour apporter une correction à un cours, vous avez deux solutions :</p>
      <div class="list-group text-start mb-4">
        <nuxt-link
          class="list-group-item list-group-item-action text-decoration-none"
          to="/a-propos/#contact"
        >
          <ski-icon icon="envelope-fill" /> Me contacter
        </nuxt-link>
        <a
          class="list-group-item list-group-item-action text-decoration-none"
          :href="`${githubRepo}/edit/master/latex/lessons/${lesson.level}/${lesson.id}.tex`"
        >
          <ski-icon icon="github" /> Modifier le code source de la page
        </a>
      </div>
    </ski-modal>
  </div>
</template>

<style lang="scss" scoped>
.list-group-item {
  color: var(--bs-list-group-color) !important;
}
</style>
