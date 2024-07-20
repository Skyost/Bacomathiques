<script setup lang="ts">
import { site } from '~/site/site'
import LessonHeaderOption from '~/components/Lesson/Options/LessonHeaderOption.vue'
import type { Lesson } from '~/types'

defineProps<{ lesson: Lesson }>()

const isShowingModal = ref<boolean>(false)

const githubRepo = `https://github.com/${site.github.username}/${site.github.repository}`
</script>

<template>
  <div class="d-inline-block">
    <lesson-header-option
      id="caveat"
      title="Signaler une erreur"
      @click="isShowingModal = !isShowingModal"
    />
    <b-modal
      id="modal-caveat"
      v-model="isShowingModal"
      title="Signaler une erreur"
      size="lg"
      ok-variant="secondary"
      ok-title="Fermer"
      ok-only
    >
      <p>Pour apporter une correction à un cours, vous avez deux solutions :</p>
      <div class="list-group text-start mb-4">
        <nuxt-link
          class="list-group-item list-group-item-action text-decoration-none"
          to="/a-propos/#contact"
        >
          <icon name="bi:envelope-fill" /> Me contacter
        </nuxt-link>
        <a
          class="list-group-item list-group-item-action text-decoration-none"
          :href="`${githubRepo}/edit/master/content/latex/lessons/${lesson.level}/${lesson.id}.tex`"
        >
          <icon name="bi:github" /> Modifier le code source de la page
        </a>
      </div>
    </b-modal>
  </div>
</template>

<style lang="scss" scoped>
.list-group-item {
  color: var(--bs-list-group-color) !important;
}
</style>
