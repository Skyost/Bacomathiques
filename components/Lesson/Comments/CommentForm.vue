<template>
  <div>
    <h2>Vous avez aimé ce cours ?</h2>
    <p>Faîtes-le nous savoir dans les commentaires !</p>
    <form
      class="comment-form"
      action="https://vercel.bacomathiqu.es/api/post-comment"
      method="post"
      @submit.prevent="onSubmit"
    >
      <input name="lesson" type="hidden" :value="lesson.id">
      <input name="level" type="hidden" :value="lesson.level">
      <input name="client" type="hidden" value="bacomathiqu.es">
      <textarea
        v-model="form.message"
        class="form-control mb-3"
        name="message"
        rows="5"
        placeholder="Exprimez-vous !"
        required
      />
      <div class="position-relative mb-3">
        <img
          :src="avatar"
          alt="Avatar (prévisualisation)"
          title="Avatar (prévisualisation)"
          class="comment-avatar"
        >
        <ski-form-control
          v-model="form.author"
          class="comment-author form-control"
          name="author"
          placeholder="Nom d'utilisateur"
          required
        />
      </div>
      <div class="clearfix">
        <ski-button variant="white" class="float-end" type="submit" :disabled="!form.enabled">
          <ski-icon icon="check-all" /> Envoyer
        </ski-button>
      </div>
      <div v-if="form.success" class="alert alert-success">
        <ski-icon icon="check" /> Votre commentaire a été envoyé avec succès. Veuillez cependant noter qu'il ne sera publié qu'après modération 😉
      </div>
      <div v-if="form.error" class="alert alert-danger">
        <ski-icon icon="exclamation-circle-fill" /> Impossible de poster votre commentaire. Veuillez réessayer plus tard.
      </div>
    </form>
  </div>
</template>

<script>
import debounce from 'just-debounce-it'
import { getAvatarURL } from '~/utils/lesson'
import site from '~/site'

export default {
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
  computed: {
    currentAddress () {
      return site.getCurrentAddress(this.$route)
    }
  },
  watch: {
    'form.author' (author) {
      if (this.debounced !== null) {
        this.debounced.cancel()
      }

      this.debounced = debounce(() => {
        this.avatar = getAvatarURL(author)
        this.debounced = null
      }, 300)
      this.debounced()
    }
  },
  async mounted () {
    this.avatar = getAvatarURL(this.form.author)
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
.comment-form {
  .comment-avatar {
    position: absolute;
    top: 0;
    left: 0;
    bottom: 0;
  }

  .alert {
    display: flex;
    align-items: center;
    margin-top: 1rem;
  }
}
</style>
