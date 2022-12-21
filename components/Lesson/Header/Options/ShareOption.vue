<template>
  <div class="d-inline-block">
    <lesson-header-option
      id="share"
      data-bs-toggle="modal"
      data-bs-target="#modal-share"
      title="Partager le cours"
    />
    <ski-modal id="modal-share" title="Partager le cours" close-button="Fermer">
      <div class="list-group text-start mb-4">
        <a
          class="list-group-item list-group-item-action text-decoration-none"
          :href="`https://twitter.com/intent/tweet?text=Retrouvez%20le%20cours%20intitul%C3%A9%20%22${encodeURI(lesson.title)}%22%20sur%20${encodeURI(siteName)}%20!&url=${encodeURI(currentAddress)}`"
          target="_blank"
        >
          <ski-icon icon="twitter" /> Partager sur Twitter
        </a>
        <a
          class="list-group-item list-group-item-action text-decoration-none"
          :href="`https://www.facebook.com/sharer/sharer.php?u=${encodeURI(currentAddress)}&t=`"
          target="_blank"
        >
          <ski-icon icon="facebook" /> Partager sur Facebook
        </a>
        <a
          class="list-group-item list-group-item-action text-decoration-none"
          :href="`mailto:?subject=&body=Retrouvez%20le%20cours%20intitul%C3%A9%20%22${encodeURI(lesson.title)}%22%20sur%20${encodeURI(siteName)}%20!%20${encodeURI(currentAddress)}`"
          target="_blank"
        >
          <ski-icon icon="envelope-fill" /> Partager par Email
        </a>
      </div>

      <p>Sinon, vous pouvez directement copier le lien vers ce cours dans votre presse-papier :</p>
      <input class="form-control w-100" type="text" :value="currentAddress" readonly>
    </ski-modal>
  </div>
</template>

<script>
import LessonHeaderOption from '~/components/Lesson/Header/Options/LessonHeaderOption'
import site from '~/site'

export default {
  components: { LessonHeaderOption },
  props: {
    lesson: {
      type: Object,
      required: true
    }
  },
  computed: {
    siteName () {
      return site.name
    },
    currentAddress () {
      return site.getCurrentAddress(this.$route)
    }
  }
}
</script>

<style lang="scss" scoped>
.list-group-item {
  color: var(--bs-list-group-color) !important;
}
</style>
