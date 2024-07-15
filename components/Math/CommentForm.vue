<script setup lang="ts">
import debounce from 'just-debounce-it'
import { getAvatarUrl } from '~/site/site'

const formLoading = ref(false)
const submitSuccess = ref<boolean | null>(null)
const submitError = ref<boolean | null>(null)
const author = ref('')
const message = ref('')
const method = ref<'POST' | 'GET'>('POST')

const debounced = ref<ReturnType<typeof debounce> | null>(null)
const avatar = ref<string | undefined>(undefined)

const avatarInputElement = ref<HTMLInputElement>()
const avatarImageElement = ref<HTMLImageElement>()

const onSubmitCommentForm = async (event: Event) => {
  submitSuccess.value = null
  submitError.value = null
  formLoading.value = true
  try {
    const form = event.target! as HTMLFormElement
    const formData = new FormData(form)
    let formBody = ''
    formData.forEach(function (value, prop) {
      formBody += (encodeURIComponent(prop.toString()) + '=' + encodeURIComponent(value.toString()) + '&')
    })
    if (formBody.length > 0) {
      formBody = formBody.substring(0, formBody.length - 1)
    }
    const response = await fetch(form.action, {
      method: form.method,
      body: formBody,
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
    })
    submitError.value = !response.ok
    submitSuccess.value = !submitError.value
  }
  catch (ex) {
    submitError.value = true
  }
  formLoading.value = false
}

watch(author, (author) => {
  if (debounced.value) {
    debounced.value.cancel()
  }

  const updateAvatar = debounce(() => {
    avatar.value = getAvatarUrl(author)
    debounced.value = null
  }, 300)
  debounced.value = updateAvatar
  updateAvatar()
})

onMounted(async () => {
  avatar.value = getAvatarUrl(author.value)
  await nextTick()
  avatarImageElement.value!.style.height = `${avatarInputElement.value!.offsetHeight}px`
  avatarInputElement.value!.style.paddingLeft = `${avatarInputElement.value!.offsetHeight + 6}px`
})
</script>

<template>
  <div>
    <slot name="title" />
    <form
      class="comment-form"
      action="https://vercel.bacomathiqu.es/api/post-comment"
      :method="method"
      @submit.prevent="onSubmitCommentForm"
    >
      <slot name="inputs" />
      <input
        name="client"
        type="hidden"
        value="bacomathiqu.es"
      >
      <textarea
        v-model="message"
        class="form-control mb-3"
        name="message"
        rows="5"
        placeholder="Exprimez-vous !"
        required
      />
      <div class="position-relative mb-3">
        <img
          ref="avatarImageElement"
          :src="avatar"
          alt="Avatar (prévisualisation)"
          title="Avatar (prévisualisation)"
          class="comment-avatar"
        >
        <input
          ref="avatarInputElement"
          v-model="author"
          type="text"
          class="comment-author form-control"
          name="author"
          placeholder="Nom d'utilisateur"
          required
        >
      </div>
      <b-row>
        <b-col
          xs="12"
          sm="6"
          md="3"
        >
          <b-button
            variant="white"
            type="submit"
            class="d-block w-100"
            :disabled="formLoading === true || submitSuccess === true"
          >
            <icon name="bi:send-fill" /> Envoyer
          </b-button>
        </b-col>
        <b-col
          xs="12"
          sm="6"
          md="9"
          class="mt-2 mt-0-lg text-end"
        >
          <small v-if="!submitSuccess && !submitError">
            <icon name="bi:incognito" /> Protégé par Akismet (<a href="https://akismet.com/privacy/">Politique de confidentialité</a> &amp; <a href="https://akismet.com/tos/">Conditions d'utilisation</a>).
          </small>
          <div
            v-if="submitSuccess"
            class="alert alert-success"
          >
            <icon
              name="bi:check"
              class="me-2"
            /> Votre commentaire a été envoyé avec succès. Veuillez cependant noter qu'il ne sera publié qu'après modération 😉
          </div>
          <div
            v-if="submitError"
            class="alert alert-danger"
          >
            <icon
              name="bi:exclamation-circle-fill"
              class="me-2"
            /> Impossible de poster votre commentaire. Veuillez réessayer plus tard.
          </div>
        </b-col>
      </b-row>
    </form>
  </div>
</template>

<style lang="scss" scoped>
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
