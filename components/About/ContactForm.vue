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

    <form class="contact-form" method="post" action="https://formspree.io/moqkkawg" @submit.prevent="onSubmit">
      <ski-columns>
        <ski-column md="6">
          <ski-form-control
            v-model="form.name"
            name="name"
            placeholder="Entrez votre nom et prénom / pseudonyme"
            required
          />
        </ski-column>
        <ski-column md="6">
          <ski-form-control
            v-model="form.email"
            name="_replyto"
            placeholder="Entrez votre adresse e-mail"
            required
          />
        </ski-column>
      </ski-columns>
      <select
        v-model="form.subject"
        name="subject"
        :value="subjects[0]"
        class="form-control mt-3"
        required
      >
        <option
          v-for="subject in subjects"
          :key="subject"
          :value="subject"
        >
          {{ subject }}
        </option>
      </select>
      <textarea
        v-model="form.message"
        name="message"
        rows="5"
        placeholder="Entrez votre message"
        required
        class="form-control mt-3 mb-3"
      />
      <div class="clearfix">
        <small class="text-muted float-start">
          <ski-icon icon="eye-fill" /> Protégé par reCaptcha (<a href="https://policies.google.com/privacy">Politique de confidentialité</a> &amp; <a href="https://policies.google.com/terms">Conditions d'utilisation</a>).
        </small>
        <ski-button variant="white" class="float-end" type="submit" :disabled="!form.enabled">
          <ski-icon icon="check-all" /> Envoyer
        </ski-button>
      </div>
      <div v-if="form.success" class="alert alert-success">
        <ski-icon icon="check" /> Message envoyé avec succès !
      </div>
      <div v-if="form.error" class="alert alert-danger">
        <ski-icon icon="exclamation-circle-fill" /> Une erreur est survenue pendant l'envoi du message. Veuillez réessayer plus tard.
      </div>
    </form>
  </div>
</template>

<script>
import { load } from 'recaptcha-v3'

export default {
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
    this.form.subject = this.subjects[0]
  },
  methods: {
    async onSubmit (event) {
      this.form.enabled = false
      try {
        const form = event.target
        const recaptcha = await load('6LesY2MhAAAAAG0AhWnGpMBLXAv3H4Bb7R3MQlYR', { autoHideBadge: true })
        const token = await recaptcha.execute('contact')
        const response = await $fetch(form.action, {
          method: form.method,
          body: {
            name: this.name,
            _replyto: this.email,
            subject: this.subject,
            message: this.message,
            'g-recaptcha-response': token
          }
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

  .alert {
    display: flex;
    align-items: center;
    margin-top: 1rem;
  }
}
</style>
