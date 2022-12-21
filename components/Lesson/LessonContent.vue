<template>
  <ski-columns>
    <ski-column width="12" lg="9" class="ps-0 pe-0">
      <page-content id="page-content">
        <content-renderer :value="lesson" />
      </page-content>
    </ski-column>

    <ski-column lg="3" class="d-lg-block d-none ps-0 pe-0">
      <lesson-navigation :toc="lesson.body.toc.links" />
    </ski-column>
  </ski-columns>
</template>

<script>
import PageContent from '~/components/PageContent'
import LessonNavigation from '~/components/Lesson/LessonNavigation'

export default {
  components: { PageContent, LessonNavigation },
  props: {
    lesson: {
      type: Object,
      required: true
    }
  }
}
</script>

<style lang="scss" scoped>
@import 'assets/bootstrap-mixins';
@import 'assets/highlighting';
@import 'assets/math';

#page-content {
  background-color: white;
  padding: 40px;
  text-align: left;
  box-shadow: 0 0 30px rgba(black, 0.2);
  z-index: 1;
  counter-reset: headline-2 headline-3;

  @include media-breakpoint-down(md) {
    padding-left: 20px;
    padding-right: 20px;
  }
}
</style>
