<template>
  <div>
    <h2>Vous avez aimé ce cours ?</h2>
    <p>Faîtes-le nous savoir dans les commentaires !</p>
    <b-form action="https://postman.bacomathiqu.es/v3/entry/github/Skyost/Bacomathiques/master/comments" method="post" @submit.prevent="onSubmit">
      <input name="options[redirect]" type="hidden" :value="`${getCurrentAddress()}#commentaires`">
      <input name="options[slug]" type="hidden" :value="`${lesson.level}_${lesson.id}`">
      <input name="fields[lesson]" type="hidden" :value="lesson.id">
      <input name="fields[level]" type="hidden" :value="lesson.level">
      <input name="fields[client]" type="hidden" value="bacomathiqu.es">
      <b-form-group>
        <b-form-textarea
          v-model="form.message"
          name="fields[message]"
          rows="5"
          placeholder="Exprimez-vous !"
          required
        />
      </b-form-group>
      <b-form-group>
        <div class="position-relative">
          <img
            :src="avatar"
            alt="Avatar (prévisualisation)"
            title="Avatar (prévisualisation)"
            class="comment-avatar"
          >
          <b-form-input
            v-model="form.author"
            class="comment-author form-control"
            name="fields[author]"
            type="text"
            placeholder="Nom d'utilisateur"
            required
          />
        </div>
      </b-form-group>
      <b-form-row>
        <b-col cols="6" md="3" offset="6" offset-md="9">
          <b-button class="btn-white float-right w-100" type="submit" :disabled="!form.enabled">
            <b-icon-check-all /> Envoyer
          </b-button>
        </b-col>
      </b-form-row>
      <b-alert variant="success" class="mt-3" :show="form.success">
        <b-icon-check /> Votre commentaire a été envoyé avec succès. Veuillez cependant noter qu'il ne sera publié qu'après modération 😉
      </b-alert>
      <b-alert variant="danger" class="mt-3" :show="form.error">
        <b-icon-exclamation-circle-fill /> Impossible de poster votre commentaire. Veuillez réessayer plus tard.
      </b-alert>
    </b-form>
  </div>
</template>

<script>
import debounceFn from 'debounce-fn'
import { BIconCheckAll, BIconCheck, BIconExclamationCircleFill } from 'bootstrap-vue'

export default {
  name: 'CommentForm',
  components: { BIconCheckAll, BIconCheck, BIconExclamationCircleFill },
  props: {
    lesson: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      debounced: null,
      avatar: null,
      form: {
        enabled: true,
        author: null,
        message: null,
        success: false,
        error: false
      }
    }
  },
  watch: {
    'form.author' (author) {
      if (this.debounced !== null) {
        this.debounced.cancel()
      }

      this.debounced = debounceFn(() => {
        this.avatar = this.getAvatarURL(author)
        this.debounced = null
      }, { wait: 300 })
      this.debounced()
    }
  },
  async mounted () {
    this.avatar = this.getAvatarURL(this.form.author)
    await this.$nextTick()
    const authorInput = this.$el.querySelector('.comment-author')
    this.$el.querySelector('.comment-avatar').style.height = `${authorInput.offsetHeight}px`
    authorInput.style.paddingLeft = `${authorInput.offsetHeight + 6}px`
  },
  methods: {
    async onSubmit (event) {
      this.form.enabled = false

      try {
        const formdata = new FormData(event.target)
        const json = {}
        formdata.forEach(function (value, prop) {
          json[prop] = value
        })
        const formBody = Object.keys(json).map(key => encodeURIComponent(key) + '=' + encodeURIComponent(json[key])).join('&')
        const response = await fetch(event.target.action, {
          method: event.target.method,
          body: formBody,
          headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
        })
        this.onResponse(response.ok)
      } catch (ex) {
        this.onResponse(false)
      }
    },
    onResponse (ok) {
      if (ok) {
        this.form.success = true
        this.form.author = null
        this.form.message = null
      } else {
        this.form.success = false
        this.form.enabled = true
      }
    }
  }
}
</script>

<style lang="scss">
  .comment-avatar {
    position: absolute;
    top: 0;
    left: 0;
    bottom: 0;
  }
</style>
