<template>
  <b-row>
    <b-col cols="12" lg="9" class="pl-0 pr-0">
      <page-content v-if="content">
        <nuxt-content :document="content" />
        <e3-c-button v-if="!isSummary" :lesson="lesson" />
      </page-content>
    </b-col>

    <b-col v-if="tocReady" lg="3" class="d-lg-block d-none pl-0 pr-0">
      <lesson-navigation :toc="content.toc" />
    </b-col>
  </b-row>
</template>

<script>
import Vue from 'vue'
import PageContent from '../PageContent'
import E3CButton from './E3CButton'
import LessonNavigation from './LessonNavigation'
import AdByGoogle from './AdByGoogle'

export default {
  name: 'LessonContent',
  components: { LessonNavigation, E3CButton, PageContent },
  props: {
    content: {
      type: Object,
      required: true
    },
    lesson: {
      type: Object,
      required: true
    },
    isSummary: {
      type: Boolean,
      default: false
    }
  },
  data () {
    return {
      tocReady: false
    }
  },
  async mounted () {
    await this.$nextTick()
    this.addTableClasses()
    this.numberizeTitles()
    this.setupToc()
    this.handleTitles()
  },
  methods: {
    addTableClasses () {
      const tables = this.$el.querySelectorAll('#page-content table')
      for (const table of tables) {
        table.classList.add('table')
        table.classList.add('table-bordered')
        table.classList.add('table-hover')
      }
    },
    numberizeTitles () {
      const titles = this.$el.querySelectorAll('h2, h3')
      const counter = { H2: 1, H3: 1 }
      for (const title of titles) {
        if (title.tagName === 'H2') {
          counter.H3 = 1
          title.innerHTML = `${this.romanize(counter.H2)} – ${title.innerHTML}`
        } else if (title.tagName === 'H3') {
          title.innerHTML = `${counter.H3}. ${title.innerHTML}`
        }
        counter[title.tagName] += 1
      }
    },
    setupToc () {
      for (const entry of this.content.toc) {
        if (entry.id) {
          entry.html = this.$el.querySelector('#' + entry.id).innerHTML
        }
      }
      this.tocReady = true
    },
    handleTitles () {
      const titles = this.$el.querySelectorAll('h2, h3')
      let adCount = 0
      for (const title of titles) {
        if (title.tagName === 'H2' && adCount < 4) {
          const element = document.createElement('div')
          title.parentElement.insertBefore(element, title)
          new Vue(AdByGoogle).$mount(element)
          adCount++
        }
        let attributes = ''
        for (const attribute of title.attributes) {
          if (attribute.name.startsWith('data-v')) {
            attributes += attribute.name
          }
        }
        title.insertAdjacentHTML('beforeend', `<a aria-hidden="true" href="#${title.id}" tabindex="-1" ${attributes}><span class="anchor" ${attributes}></span></a>`)
      }
    },
    romanize (num) {
      if (!+num) {
        return false
      }
      const digits = String(+num).split('')
      const key = ['', 'C', 'CC', 'CCC', 'CD', 'D', 'DC', 'DCC', 'DCCC', 'CM',
        '', 'X', 'XX', 'XXX', 'XL', 'L', 'LX', 'LXX', 'LXXX', 'XC',
        '', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX']
      let roman = ''
      let i = 3
      while (i--) {
        roman = (key[+digits.pop() + (i * 10)] || '') + roman
      }
      return Array(+digits.join('') + 1).join('M') + roman
    }
  }
}
</script>

<style lang="scss" scoped>
@import 'assets/breakpoints';
@import 'assets/colors';
@import 'assets/highlighting';
@import 'assets/math';

#page-content {
  background-color: white;
  padding: 40px;
  text-align: left;
  box-shadow: 0 0 30px rgba(black, 0.2);
  z-index: 1;

  h2,
  h3 {
    .anchor {
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

    &:hover .anchor {
      margin-left: 0.2em;
      opacity: 1;
    }
  }

  h2 {
    font-size: 2.4rem;
    color: #23618a;
    padding-bottom: 0.5rem;
    margin-top: 2.4rem;
    margin-bottom: 1.4rem;
    border-bottom: 1px solid rgba(black, 0.1);
    text-align: left;

    &:first-of-type {
      margin-top: 0;
    }
  }

  h3 {
    color: $main-color;
    margin-bottom: 1rem;
    text-align: left;
  }

  h4 {
    text-align: left;
  }

  .table th {
    font-weight: normal;
  }

  #lesson-e3c .btn {
    font-weight: normal !important;
  }

  @media (max-width: $mobile-width) {
    padding-left: 20px;
    padding-right: 20px;
  }
}
</style>
