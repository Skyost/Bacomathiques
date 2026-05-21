<script setup lang="ts">
import { load } from 'recaptcha-v3'
import PageHead from '~/components/Page/PageHead.vue'
import PageHeader from '~/components/Page/PageHeader.vue'
import BigCard from '~/components/Cards/BigCard.vue'
import Carousel from '~/components/Page/Carousel/Carousel.vue'
import CardColumn from '~/components/Cards/CardColumn.vue'
import { site } from '~/site/site'

const technologieCards = [
  {
    id: 'vue',
    content: 'Ce site web a été créé (notamment) avec le framework <a href="https://vuejs.org/">Vue.js</a>, vous pouvez consulter le <pre class="d-inline mb-0">package.json</pre> en cliquant <a href="https://github.com/Skyost/Bacomathiques/blob/master/package.json">ici</a>.'
  },
  {
    id: 'nuxt',
    content: 'Le site utilise le moteur <a href="https://nuxtjs.org/">Nuxt.js</a> pour générer ses contenus et est hébergé sur <a href="https://pages.github.com/">Github Pages</a>.'
  },
  {
    id: 'pencil',
    content: `Les icônes de la <a href="https://www.iconfinder.com/iconsets/small-n-flat">page de présentation</a>,
            du <a href="https://www.flaticon.com/packs/education-1-11">carousel</a>,
            des <a href="https://www.flaticon.com/packs/greek-symbols">niveaux</a>,
            des <a href="https://www.flaticon.com/packs/logos-and-brands">magasins d'applications</a>,
            de <a href="https://www.flaticon.com/free-icon/pdf_136522">fichier PDF</a>,
            de <a href="https://www.flaticon.com/free-icon/pdf_136522">partage</a>,
            d'<a href="https://www.flaticon.com/free-icon/pdf_136522">avertissement</a>,
            de <a href="https://www.iconfinder.com/icons/2064495/education_graduation_learn_school_student_study_icon">diplôme</a>,
            de <a href="https://www.flaticon.com/free-icon/magnifying-glass_3003596">recherche</a>,
            et <a href="https://www.iconfinder.com/iconsets/tutor-icon-set">Bacomathiques</a> proviennent de IconFinder et de FlatIcon.
            <br>Les autres icônes proviennent de <a href="https://fontawesome.io/">FontAwesome</a>.`
  }
]

const subjects = [
  'Correction à apporter',
  'Rapport de bug',
  'Idée d\'amélioration',
  'Autre'
]

const formLoading = ref(false)
const submitSuccess = ref<boolean | null>(null)
const submitError = ref<boolean | null>(null)
const name = ref('')
const email = ref('')
const subject = ref(subjects[0])
const message = ref('')
const method = ref<'POST' | 'GET'>('POST')

const onSubmitContactForm = async (event: Event) => {
  submitSuccess.value = null
  submitError.value = null
  formLoading.value = true
  try {
    const form = event.target! as HTMLFormElement
    const recaptcha = await load('6LesY2MhAAAAAG0AhWnGpMBLXAv3H4Bb7R3MQlYR', { autoHideBadge: true })
    const token = await recaptcha.execute('contact')
    const response: object = await $fetch(form.action, {
      method: method.value,
      body: {
        'name': name.value,
        '_replyto': email.value,
        'subject': subject.value,
        'message': message.value,
        'g-recaptcha-response': token
      }
    })
    if ('ok' in response && response.ok) {
      submitSuccess.value = true
    }
    else {
      submitError.value = true
    }
  }
  catch {
    submitError.value = true
  }
  formLoading.value = false
}

useSal()
</script>

<template>
  <div>
    <page-head title="À propos" />

    <page-header>
      <carousel />
    </page-header>

    <page-content>
      <section class="pb-5">
        <cards-row sal="slide-up">
          <card-column
            v-for="card in technologieCards"
            :key="card.id"
            class="mb-5"
            :image="`/img/about/${card.id}.svg`"
            :size="3"
          >
            <span v-html="card.content" />
          </card-column>
        </cards-row>
      </section>

      <section
        class="pt-5 pb-5"
        data-sal="slide-right"
      >
        <big-card>
          <h2 id="licence-contributions">
            Licences &amp; contributions
          </h2>

          <p>
            Les cours ont été écrits intégralement par <a href="https://skyost.eu">Hugo Delaunay</a>,
            Toute reproduction totale ou partielle est interdite excepté pour un usage pédagogique et non commercial (en citant explicitement la propriété de {{ site.name }}).
            Certaines démonstrations sont tirées de <a href="https://www.sesamath.net/">Sésamath</a>,
            et certaines introductions ont été reprises de <a href="https://fr.wikipedia.org">Wikipédia</a>.
          </p>

          <p>
            Toutes les technologies intégrées dans ce site web sont disponibles sous licence <strong>GNU GPL v3</strong>.
            N'hésitez pas à aller faire un tour sur leurs pages respectives !
          </p>

          <hr>

          <p>
            Il existe énormément de moyens de <strong>contribuer</strong> au projet {{ site.name }} !
            Vous pouvez y faire des modifications ou même tout simplement lui donner une étoile sur
            <a :href="`https://github.com/${site.github.username}/${site.github.repository}`">Github</a>.
            Il vous est également possible d'effectuer des dons via <a href="https://paypal.me/Skyost">PayPal</a>.
          </p>

          <b-button
            href="https://paypal.me/Skyost"
            class="paypal-button"
            variant="primary"
          >
            <img
              src="/img/about/paypal.svg"
              alt="PayPal"
            >
          </b-button>

          <p>
            Par ailleurs, les contributions sont facultatives et vous pouvez pleinement profiter
            de {{ site.name }} sans aucune action de votre part. Sachez cependant que les contributions sont
            très appréciées. 😉
          </p>
        </big-card>
      </section>

      <section class="pt-5 pb-5">
        <big-card
          blue
          sal="slide-down"
        >
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

          <form
            class="contact-form"
            method="post"
            action="https://formspree.io/moqkkawg"
            @submit.prevent="onSubmitContactForm"
          >
            <b-row>
              <b-col md="6">
                <b-form-input
                  v-model="name"
                  name="name"
                  placeholder="Entrez votre nom et prénom / pseudonyme"
                  required
                />
              </b-col>
              <b-col md="6">
                <b-form-input
                  v-model="email"
                  name="_replyto"
                  placeholder="Entrez votre adresse e-mail"
                  required
                />
              </b-col>
            </b-row>
            <b-form-select
              v-model="subject"
              name="subject"
              :value="subjects[0]"
              class="form-control mt-3"
              required
            >
              <option
                v-for="availableSubject in subjects"
                :key="availableSubject"
                :value="availableSubject"
                v-text="availableSubject"
              />
            </b-form-select>
            <b-form-textarea
              v-model="message"
              name="message"
              rows="5"
              placeholder="Entrez votre message"
              required
              class="form-control mt-3 mb-3"
            />
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
                <small class="text-muted">
                  <icon name="bi:eye-fill" /> Protégé par reCaptcha (<a href="https://policies.google.com/privacy">Politique de confidentialité</a> &amp; <a href="https://policies.google.com/terms">Conditions d'utilisation</a>).
                </small>
              </b-col>
            </b-row>
            <div
              v-if="submitSuccess"
              class="alert alert-success"
            >
              <icon
                name="bi:check"
                class="me-2"
              /> Message envoyé avec succès !
            </div>
            <div
              v-if="submitError"
              class="alert alert-danger"
            >
              <icon
                name="bi:exclamation-circle-fill"
                class="me-2"
              /> Une erreur est survenue pendant l'envoi du message. Veuillez réessayer plus tard.
            </div>
          </form>
        </big-card>
      </section>
    </page-content>
  </div>
</template>

<style lang="scss" scoped>
.paypal-button {
  display: block;
  text-align: center;
  margin-bottom: 1rem;
  padding: 20px;

  img {
    height: 30px;
    max-width: 100%;
  }
}

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
