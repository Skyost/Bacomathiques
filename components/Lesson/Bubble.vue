<template>
  <div>
    <span v-if="hideMessage" class="bubble-label" @click="hidden = !hidden">
      <b-icon-chevron-right v-if="hidden" /><b-icon-chevron-down v-else /> {{ hideMessage }}
    </span>
    <slide-up-down :active="!hidden" role="main">
      <div class="bubble-content" :class="variant">
        <slot />
      </div>
    </slide-up-down>
  </div>
</template>

<script>
import { BIconChevronDown, BIconChevronRight } from 'bootstrap-vue'
import SlideUpDown from 'vue-slide-up-down'

export default {
  name: 'Bubble',
  components: { SlideUpDown, BIconChevronRight, BIconChevronDown },
  props: {
    variant: {
      type: String,
      required: true
    },
    contentWidth: {
      type: String,
      default: 'medium'
    }
  },
  data () {
    return {
      hidden: this.variant === 'proof' || this.variant === 'correction'
    }
  },
  computed: {
    hideMessage () {
      switch (this.variant) {
        case 'proof':
          return 'Démonstration'
        case 'correction':
          return 'Correction'
        default:
          return null
      }
    }
  }
}
</script>

<style lang="scss" scoped>
@import 'assets/breakpoints';
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
    color: $linkColor;
    text-decoration-color: $linkDecorationColor;

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

.bubble-label {
  display: block;
  font-size: 0.8em;
  text-align: right;
  color: rgba(black, 0.6);
  cursor: pointer;
  margin-bottom: 1rem;
}

::v-deep .bubble-content {
  position: relative;
  display: block;
  margin-bottom: 1rem;
  overflow-x: auto;
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
    display: block;
    margin: 0.6rem auto 0.8rem auto;
    max-height: 200px;
    width: 90%;
    object-fit: contain;
  }

  > .sourceCode[data-language] > .sourceCode {
    padding: 10px;
  }

  @include bubble-li();

  &.formula {
    @include bubble('À connaître 💡', $main-color, #ebf3fb, #217dbb, #a0cfee);
  }

  &.proof {
    @include bubble('Démonstration 🧠', #f1c40f, #fff8de, #e09e0d, #f1c40f);
  }

  &.tip {
    @include bubble('À lire 👀', #26a65b, #dcf3d8, #13532e, #219150);
  }

  &.exercise {
    @include bubble('Exercice ✍', #009688, #e0f2f1, #006f65, #009688);
  }

  &.correction {
    @include bubble('Correction 💯', #00bcd4, #e0f7fa, #006b78, #00bcd4);
  }
}
</style>
