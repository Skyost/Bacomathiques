<template>
  <ski-container :fluid="true">
    <ski-columns :data-sal="sal" class="justify-content-center">
      <ski-column width="12" xl="9" lg="10" class="pr-md-0 pl-md-0">
        <flat-card :big="true" :blue="blue">
          <slot />
        </flat-card>
      </ski-column>
    </ski-columns>
  </ski-container>
</template>

<script>
import FlatCard from '~/components/Cards/FlatCard'

export default {
  components: { FlatCard },
  props: {
    sal: {
      type: String,
      default: null
    },
    blue: {
      type: Boolean,
      default: false
    }
  }
}
</script>
