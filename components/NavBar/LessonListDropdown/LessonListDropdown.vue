<template>
  <b-nav-item-dropdown class="ml-auto" right>
    <template #button-content>
      <b-icon-tag-fill /> Accès direct à un cours
    </template>
    <b-dropdown-form action="/recherche/" method="get">
      <b-form-input
        v-model="searchTerms"
        type="search"
        name="requete"
        placeholder="Chercher un cours..."
      />
    </b-dropdown-form>
    <dropdown-entries v-for="level in levels" :key="level.id" :level="level" :search-terms="searchTerms" />
  </b-nav-item-dropdown>
</template>

<script>
import { BIconTagFill } from 'bootstrap-vue'
import DropdownEntries from './DropdownEntries'

export default {
  name: 'LessonListDropdown',
  components: { BIconTagFill, DropdownEntries },
  data () {
    return {
      searchTerms: null,
      levels: []
    }
  },
  async fetch () {
    this.levels = await this.$content('levels').sortBy('order').fetch()
  }
}
</script>
