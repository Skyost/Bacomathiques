<template>
  <b-modal id="modal-lesson-list" title="Accès direct à un cours" hide-footer>
    <ul>
      <dropdown-entries
        v-for="level in levels"
        :key="level.id"
        :level="level"
        :click-callback="closeModal"
      />
    </ul>
  </b-modal>
</template>

<script>
import DropdownEntries from './LessonListDropdown/DropdownEntries'

export default {
  name: 'LessonListModal',
  components: { DropdownEntries },
  data () {
    return {
      levels: []
    }
  },
  async fetch () {
    this.levels = await this.$content('levels')
      .sortBy('order')
      .fetch()
  },
  methods: {
    closeModal () {
      this.$bvModal.hide('modal-lesson-list')
    }
  }
}
</script>

<style lang="scss">
#modal-lesson-list ul {
  list-style-type: none;
  margin-bottom: 0;
  padding-left: 0;

  .dropdown-header,
  .dropdown-item {
    padding-left: 0;
    padding-right: 0;
    white-space: normal;
  }
}
</style>
