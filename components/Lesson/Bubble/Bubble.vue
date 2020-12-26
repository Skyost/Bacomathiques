<template>
  <div>
    <span v-if="hideMessage" class="bubble-label" @click="hidden = !hidden">
      <b-icon-chevron-right v-if="hidden" /><b-icon-chevron-down v-else /> {{ hideMessage }}
    </span>
    <div v-if="!hidden" class="content">
      <formula-bubble v-if="variant === 'formula'">
        <slot />
      </formula-bubble>
      <tip-bubble v-else-if="variant === 'tip'">
        <slot />
      </tip-bubble>
      <proof-bubble v-else-if="variant === 'proof'">
        <slot />
      </proof-bubble>
    </div>
  </div>
</template>

<script>
import { BIconChevronRight, BIconChevronDown } from 'bootstrap-vue'
import FormulaBubble from './FormulaBubble'
import TipBubble from './TipBubble'
import ProofBubble from './ProofBubble'

export default {
  name: 'Bubble',
  components: { ProofBubble, TipBubble, FormulaBubble, BIconChevronRight, BIconChevronDown },
  props: {
    variant: {
      type: String,
      required: true
    }
  },
  data () {
    return {
      hidden: this.variant === 'proof'
    }
  },
  computed: {
    hideMessage () {
      return this.variant === 'proof' ? 'Démonstration' : null
    }
  }
}
</script>

<style lang="scss">
.bubble-label {
  display: block;
  font-size: 0.8em;
  text-align: right;
  color: rgba(black, 0.6);
  cursor: pointer;
  margin-bottom: 1rem;
}
</style>
