<template>
  <li class="nav-item dropdown">
    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
      <ski-icon icon="tag-fill" /> Accès direct à un cours
    </a>
    <div class="dropdown-menu dropdown-menu-end">
      <lesson-list />
    </div>
  </li>
</template>

<script>
import LessonList from '~/components/Navbar/LessonList/LessonList'

export default {
  components: { LessonList },
  data () {
    return {
      searchTerms: null
    }
  }
}
</script>

<style lang="scss" scoped>
:deep(form) input {
  border: 0;
}
</style>
