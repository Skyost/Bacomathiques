<script setup lang="ts">
import { site } from '~/site/site'
import type { Lesson } from '~/types'
import LessonHeaderOption from '~/components/Lesson/Options/LessonHeaderOption.vue'

defineProps<{ lesson: Lesson }>()

const isShowingModal = ref<boolean>(false)

const route = useRoute()
const currentAddress = computed<string>(() => site.host + route.fullPath)
</script>

<template>
  <div class="d-inline-block">
    <lesson-header-option
      id="share"
      title="Partager le cours"
      @click="isShowingModal = !isShowingModal"
    />
    <b-modal
      id="modal-share"
      v-model="isShowingModal"
      title="Partager le cours"
      size="lg"
      close-button="Fermer"
    >
      <div class="list-group text-start mb-4">
        <a
          class="list-group-item list-group-item-action text-decoration-none"
          :href="`https://twitter.com/intent/tweet?text=Retrouvez%20le%20cours%20intitul%C3%A9%20%22${encodeURI(lesson.title)}%22%20sur%20${encodeURI(site.name)}%20!&url=${encodeURI(currentAddress)}`"
          target="_blank"
        >
          <icon name="bi:twitter" /> Partager sur Twitter
        </a>
        <a
          class="list-group-item list-group-item-action text-decoration-none"
          :href="`https://www.facebook.com/sharer/sharer.php?u=${encodeURI(currentAddress)}&t=`"
          target="_blank"
        >
          <icon name="bi:facebook" /> Partager sur Facebook
        </a>
        <a
          class="list-group-item list-group-item-action text-decoration-none"
          :href="`mailto:?subject=&body=Retrouvez%20le%20cours%20intitul%C3%A9%20%22${encodeURI(lesson.title)}%22%20sur%20${encodeURI(site.name)}%20!%20${encodeURI(currentAddress)}`"
          target="_blank"
        >
          <icon name="bi:envelope-fill" /> Partager par Email
        </a>
      </div>

      <p>Sinon, vous pouvez directement copier le lien vers ce cours dans votre presse-papier :</p>
      <input
        class="form-control w-100"
        type="text"
        :value="currentAddress"
        readonly
      >
    </b-modal>
  </div>
</template>

<style lang="scss" scoped>
.list-group-item {
  color: var(--bs-list-group-color) !important;
}
</style>
