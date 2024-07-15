<script setup lang="ts">
import { h, render, Suspense } from 'vue'
import { Collapse } from '#components'
import CommentForm from '~/components/Math/CommentForm.vue'
import BigCard from '~/components/Cards/BigCard.vue'
import CommentCard from '~/components/Cards/CommentCard.vue'
import Navigation from '~/components/Math/Navigation.vue'
import type { Comment, Toc } from '~/types'

const props = defineProps<{
  comments?: Comment[]
  toc?: Toc
  ads?: boolean
}>()

const config = useRuntimeConfig()
const debug = config.public.debug

const root = ref<HTMLElement | null>(null)

const getHideMessage = (variant: string) => {
  switch (variant) {
    case 'proof':
      return 'Démonstration'
    case 'correction':
      return 'Correction'
    default:
      return null
  }
}

const setupDocument = () => {
  const tables = root.value!.querySelectorAll('table')
  for (const table of tables) {
    table.classList.add('table', 'table-bordered', 'table-hover')
    const parent = table.parentNode
    const wrapper = document.createElement('div')
    wrapper.classList.add('table-responsive')
    parent!.replaceChild(wrapper, table)
    wrapper.appendChild(table)
  }

  const headings = root.value!.querySelectorAll('h2, h3, h4')
  for (const heading of headings) {
    if (props.ads && heading.tagName === 'H2') {
      const ad = document.createElement('ins')
      ad.setAttribute('data-ad-client', debug ? 'ca-google' : 'ca-pub-7167241518798106')
      ad.setAttribute('data-ad-slot', '4882057404')
      ad.setAttribute('data-ad-format', 'auto')
      ad.setAttribute('data-full-width-responsive', 'true')
      ad.setAttribute('data-adtest', debug ? 'on' : 'null')
      heading.parentNode?.insertBefore(ad, heading)
    }
    if (heading.id) {
      const anchor = document.createElement('a')
      anchor.setAttribute('href', `#${heading.id}`)
      anchor.classList.add('anchor')
      heading.appendChild(anchor)
    }
  }

  const bubbles = root.value!.querySelectorAll<HTMLElement>('.bubble')
  for (let i = 0; i < bubbles.length; i++) {
    const bubble = bubbles[i]
    const hideMessage = getHideMessage(bubble.getAttribute('data-variant')!)
    if (!hideMessage) {
      continue
    }
    const collapseElement = document.createElement('div')
    const id: string = bubble.getAttribute('id')!
    bubble.removeAttribute('id')
    const collapseComponent = h(Collapse, { id: id, variant: 'link', buttonClass: 'bubble-collapse-label' }, {
      default: () => h('div', { innerHTML: bubble.outerHTML }),
      button: () => hideMessage
    })
    render(collapseComponent, collapseElement)
    bubble.parentNode?.insertBefore(collapseElement, bubble)
    bubble.remove()
  }

  const representations = root.value!.querySelectorAll<HTMLElement>('.representation')
  if (representations.length > 0) {
    useHead({
      script: [
        { src: 'https://www.geogebra.org/apps/deployggb.js' }
      ]
    })
    createGeoGebraInstancesWhenPossible(representations)
  }

  if (props.ads) {
    const ensureScriptExecuteOnce = (script: string) => `if (!window.__abg_called){ ${script} window.__abg_called = true;}`
    useHead({
      script: [
        {
          src: 'https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js',
          async: true
        },
        {
          innerHTML: ensureScriptExecuteOnce('(window.adsbygoogle = window.adsbygoogle || []).push({});')
        }
      ]
    })
  }
}

const createGeoGebraInstancesWhenPossible = (representations: NodeListOf<HTMLElement>) => {
  if (!window.GGBApplet) {
    setTimeout(() => createGeoGebraInstancesWhenPossible(representations), 500)
    return
  }

  for (const representation of representations) {
    representation.id = representation.getAttribute('data-geogebra-id')!
    representation.classList.add('ms-auto', 'me-auto', 'mb-3', 'mw-100')
    const parent = representation.parentElement!
    const availableWidth = parent.getBoundingClientRect().width - parseInt(parent.style.paddingLeft.toString()) - parseInt(parent.style.paddingRight.toString())
    const width = Math.min(availableWidth, 800)

    const windowWidth = window.innerWidth
    let scale = 1
    if (windowWidth < 992) {
      scale = 2
    }
    if (windowWidth < 768) {
      scale = 4
    }

    new window.GGBApplet({
      id: representation.id,
      material_id: representation.getAttribute('data-geogebra-id'),
      height: 0.75 * width,
      width,
      showResetIcon: true,
      enableLabelDrags: false,
      scale,
      allowUpscale: true,
      scaleContainerClass: 'representation',
      // 'showZoomButtons': true,
      preventFocus: true,
      enableShiftDragZoom: true,
      borderColor: 'rgba(0, 0, 0, 0.5)'
    }, true).inject(representation.id)
  }
}

onMounted(async () => {
  await nextTick()
  setupDocument()
})
</script>

<template>
  <div>
    <b-container
      class="mb-5"
      :fluid="true"
    >
      <b-row>
        <b-col
          width="12"
          lg="9"
          class="ps-0 pe-0"
        >
          <div
            ref="root"
            class="math-document"
          >
            <slot />
          </div>
        </b-col>
        <b-col
          v-if="toc"
          lg="3"
          class="d-lg-block d-none ps-0 pe-0"
        >
          <navigation :toc="toc" />
        </b-col>
      </b-row>
    </b-container>
    <div
      v-if="comments"
      class="pt-5 pb-5"
    >
      <big-card
        class="mb-5"
        blue
      >
        <comment-form>
          <template #title>
            <slot name="comments-headings" />
          </template>
          <template #inputs>
            <slot name="comments-inputs" />
          </template>
        </comment-form>
      </big-card>
      <div
        v-if="comments.length > 0"
        class="pt-5"
      >
        <comment-card
          v-for="comment in comments"
          :key="comment._id"
          class="mb-5"
          :comment="comment"
        />
      </div>
      <em
        v-else
        class="text-muted text-center d-block pt-5 pb-5"
      >
        Il n'y a pas de commentaire sur ce cours pour le moment.
      </em>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import 'assets/colors';

@mixin bubble($text, $borderColor, $backgroundColor, $linkColor, $linkDecorationColor) {
  $borderLeft: 8px;

  padding: 20px 20px 20px (20 + $borderLeft);
  border-left: $borderLeft solid $borderColor;
  background-color: $backgroundColor;

  &::before {
    content: $text;
    background-color: $borderColor;
    padding-right: $borderLeft;
  }

  h4 {
    // color: darken($borderColor, 6%);
    color: $borderColor;
  }

  a {
    color: $linkColor !important;
    text-decoration-color: $linkDecorationColor !important;

    &:hover,
    &:active {
      color: darken($linkColor, 10%) !important;
    }
  }
}

@mixin bubble-li() {
  > li {
    padding-left: 0 !important;
    list-style-type: '— ';
  }

  li {
    margin-bottom: 0.8rem;
    padding-left: 0.2rem;

    p {
      margin-bottom: 0;
    }
  }
}

.math-document {
  counter-reset: headline-2 headline-3;

  :deep(h2), :deep(h3) {
    &:hover .anchor {
      margin-left: 0.2em;
      opacity: 1;
    }
  }

  :deep(h2) {
    font-size: 2.4rem;
    color: #23618a;
    padding-bottom: 0.5rem;
    margin-top: 2.4rem;
    margin-bottom: 1.4rem;
    border-bottom: 1px solid rgba(black, 0.1);
    text-align: left;
    counter-increment: headline-2;
    counter-set: headline-3 0;

    &:before {
      content: counter(headline-2, upper-roman) ' – ';
    }

    &:first-of-type {
      margin-top: 0;
    }
  }

  :deep(h3) {
    counter-increment: headline-3;
    color: $primary;
    margin-bottom: 1rem;
    text-align: left;

    &::before {
      content: counter(headline-3) '. ';
    }
  }

  :deep(.bubble-collapse-label) {
    display: block;
    margin-left: auto;
    font-size: 0.8em;
    padding: 0;
    text-decoration: none !important;
    color: rgba(black, 0.6);
    margin-bottom: 16px;

    .bi-chevron-down::before {
      transition: transform 200ms;
    }

    &.collapsed {
      .bi-chevron-down::before {
        transform: rotate(-90deg);
      }
    }
  }

  :deep(.bubble) {
    position: relative;
    margin-bottom: 1rem;
    // overflow-x: auto;
    page-break-inside: avoid;
    list-style-type: none;
    text-align: left;

    &::before {
      text-transform: uppercase;
      position: absolute;
      top: 0;
      left: 0;
      color: white;
      font-size: 0.6em;
      opacity: 0;
      transition: opacity 200ms;
    }

    &:hover::before {
      opacity: 1;
    }

    > *:last-child {
      margin-bottom: 0;
    }

    h4 {
      font-size: 1.25em;
      margin-bottom: 0.75rem;
    }

    ul {
      list-style-type: none;
      padding-left: 2rem;

      @include bubble-li();
    }

    > ul,
    > ol {
      &:last-child li:last-child {
        margin-bottom: 0;
      }
    }

    table {
      background-color: white;
    }

    img {
      max-width: 100%;
    }

    > .sourceCode[data-language] > .sourceCode {
      padding: 10px;
    }

    @include bubble-li();
  }

  :deep(.bubble[data-variant='formula']) {
    @include bubble('À connaître 💡', $primary, #ebf3fb, #217dbb, #a0cfee);
  }

  :deep(.bubble[data-variant='proof']) {
    @include bubble('Démonstration 🧠', #f1c40f, #fff8de, #e09e0d, #f1c40f);
  }

  :deep(.bubble[data-variant='exercise']) {
    @include bubble('Exercice ✍', #009688, #e0f2f1, #006f65, #009688);
  }

  :deep(.bubble[data-variant='correction']) {
    @include bubble('Correction 💯', #00bcd4, #e0f7fa, #006b78, #00bcd4);
  }

  :deep(.bubble[data-variant='tip']) {
    @include bubble('À lire 👀', #26a65b, #dcf3d8, #13532e, #219150);
  }

  :deep(img) {
    max-width: 100%;
  }

  :deep(table) {
    background-color: white;

    td {
      height: 2.5em;
    }
  }

  :deep(.center) {
    text-align: center;
  }

  :deep(.anchor) {
    display: inline-block;
    content: '';
    background-image: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="rgb(149, 165, 166)" viewBox="0 0 16 16"> <path d="M4.715 6.542L3.343 7.914a3 3 0 1 0 4.243 4.243l1.828-1.829A3 3 0 0 0 8.586 5.5L8 6.086a1.001 1.001 0 0 0-.154.199 2 2 0 0 1 .861 3.337L6.88 11.45a2 2 0 1 1-2.83-2.83l.793-.792a4.018 4.018 0 0 1-.128-1.287z"/> <path d="M6.586 4.672A3 3 0 0 0 7.414 9.5l.775-.776a2 2 0 0 1-.896-3.346L9.12 3.55a2 2 0 0 1 2.83 2.83l-.793.792c.112.42.155.855.128 1.287l1.372-1.372a3 3 0 0 0-4.243-4.243L6.586 4.672z"/> </svg>');
    background-repeat: no-repeat;
    background-size: 1em 1em;
    height: 1em;
    width: 1em;
    vertical-align: -0.2em;
    opacity: 0;
    transition: all 300ms;
  }

  :deep(.math) {
    font-size: 113%;
  }
}
</style>
