<template>
  <div class="d-inline-block">
    <lesson-header-option
      id="share"
      v-b-modal.modal-share
      title="Partager le cours"
    />
    <b-modal id="modal-share" title="Partager le cours" hide-footer>
      <div class="list-group rounded-0 mb-4">
        <a
          class="list-group-item list-group-item-action text-decoration-none"
          :href="`https://twitter.com/intent/tweet?text=Retrouvez%20le%20cours%20intitul%C3%A9%20%22${encodeURI(lesson.title)}%22%20sur%20${encodeURI(siteName)}%20!&url=${encodeURI(currentAddress)}`"
          target="_blank"
        >
          <b-icon-twitter /> Partager sur Twitter
        </a>
        <a
          class="list-group-item list-group-item-action text-decoration-none"
          :href="`https://www.facebook.com/sharer/sharer.php?u=${encodeURI(currentAddress)}&t=`"
          target="_blank"
        >
          <b-icon-facebook /> Partager sur Facebook
        </a>
        <a
          class="list-group-item list-group-item-action text-decoration-none"
          :href="`mailto:?subject=&body=Retrouvez%20le%20cours%20intitul%C3%A9%20%22${encodeURI(lesson.title)}%22%20sur%20${encodeURI(siteName)}%20!%20${encodeURI(currentAddress)}`"
          target="_blank"
        >
          <b-icon-envelope-fill /> Partager par Email
        </a>
      </div>

      <p>Sinon, vous pouvez directement copier le lien vers ce cours dans votre presse-papier :</p>
      <input class="form-control w-100 rounded-0" type="text" :value="currentAddress" readonly>
    </b-modal>
  </div>
</template>

<script>
import { BIconEnvelopeFill, BIconFacebook, BIconTwitter } from 'bootstrap-vue'
import LessonHeaderOption from './LessonHeaderOption'
import { getCurrentAddress, SITE_NAME } from '~/utils/site'

export default {
  name: 'ShareOption',
  components: { BIconTwitter, BIconFacebook, BIconEnvelopeFill, LessonHeaderOption },
  props: {
    lesson: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      siteName: SITE_NAME
    }
  },
  computed: {
    currentAddress () {
      return getCurrentAddress(this.$route)
    }
  }
}
</script>
