<template>
  <div>
    <h2 id="contact">
      Contact
    </h2>

    <p>
      Vous avez trouvé <strong>une faute dans un cours</strong> ?
      Vous souhaitez qu'une <strong>nouvelle fonctionnalité</strong> soit ajoutée au site web
      ou vous souhaitez tout simplement <strong>me contacter</strong> ?
    </p>

    <p>
      Pas de problème, il vous suffit de remplir le formulaire de contact ci-dessous :
    </p>

    <b-form class="contact-form" method="post" action="https://formspree.io/moqkkawg" @submit.prevent="onSubmit">
      <b-form-row>
        <b-col md="6">
          <b-form-group>
            <b-form-input
              v-model="form.name"
              name="name"
              class="form-control"
              type="text"
              placeholder="Entrez votre nom et prénom / pseudonyme"
              required
            />
          </b-form-group>
        </b-col>
        <b-col md="6">
          <b-form-group>
            <b-form-input
              v-model="form.email"
              name="_replyto"
              class="form-control"
              type="text"
              placeholder="Entrez votre adresse e-mail"
              required
            />
          </b-form-group>
        </b-col>
      </b-form-row>
      <b-form-group>
        <b-form-select
          v-model="form.subject"
          name="subject"
          class="form-control"
          :options="subjects"
          :value="subjects[0]"
          required
        />
      </b-form-group>
      <b-form-group class="mb-1">
        <b-form-textarea
          v-model="form.message"
          name="message"
          class="form-control"
          rows="5"
          placeholder="Entrez votre message"
          required
        />
      </b-form-group>
      <recaptcha />
      <small class="text-muted">
        <b-icon-eye-fill /> Protégé par reCaptcha (<a href="https://policies.google.com/privacy">Politique de confidentialité</a> &amp; <a href="https://policies.google.com/terms">Conditions d'utilisation</a>).
      </small>
      <b-form-row>
        <b-col cols="6" md="3" offset="6" offset-md="9">
          <b-button class="btn-white float-right w-100" type="submit" :disabled="!form.enabled">
            <b-icon-check-all /> Envoyer
          </b-button>
        </b-col>
      </b-form-row>
      <b-alert variant="success" class="mt-3" :show="form.success">
        <b-icon-check /> Message envoyé avec succès !
      </b-alert>
      <b-alert variant="danger" class="mt-3" :show="form.error">
        <b-icon-exclamation-circle-fill /> Une erreur est survenue pendant l'envoi du message. Veuillez réessayer plus tard.
      </b-alert>
    </b-form>
  </div>
</template>

<script>
import { BIconEyeFill, BIconCheckAll, BIconCheck, BIconExclamationCircleFill } from 'bootstrap-vue'

export default {
  name: 'ContactForm',
  components: { BIconEyeFill, BIconCheckAll, BIconCheck, BIconExclamationCircleFill },
  data () {
    return {
      form: {
        enabled: true,
        name: null,
        email: null,
        subject: null,
        message: null,
        success: false,
        error: false
      },
      subjects: [
        'Correction à apporter',
        'Rapport de bug',
        'Idée d\'amélioration',
        'Autre'
      ]
    }
  },
  mounted () {
    this.$recaptcha.init()
    this.form.subject = this.subjects[0]
  },
  methods: {
    async onSubmit (event) {
      this.form.enabled = false
      try {
        const response = await fetch(event.target.action, {
          method: event.target.method,
          body: new FormData(event.target),
          headers: { Accept: 'application/json' }
        })
        this.onResponse(response.ok)
      } catch (ex) {
        this.onResponse(false)
      }
    },
    onResponse (ok) {
      if (ok) {
        this.form.success = true
        this.form.name = null
        this.form.email = null
        this.form.subject = null
        this.form.message = null
        this.form.recaptchaToken = null
      } else {
        this.form.success = false
        this.form.enabled = true
      }
    }
  }
}
</script>

<style lang="scss">
.contact-form {
  .text-muted {
    color: rgba(white, 0.8) !important;

    a {
      color: white !important;
      text-decoration-color: rgba(white, 0.8) !important;
    }
  }

  .g-recaptcha {
    margin-top: 1em;
  }
}
</style>
