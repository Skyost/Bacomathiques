<template>
  <div>
    <ski-navbar id="page-navbar" ref="navbar" brightness="primary" class="navbar-dark">
      <ski-navbar-collapse id="page-navbar-collapse" class="collapse-container">
        <ski-navbar-items class="ms-auto ms-lg-0">
          <ski-navbar-item class="page-navbar-item" to="/" :active="$route.path === '/'">
            <ski-icon icon="house-door-fill" /> Accueil
          </ski-navbar-item>
          <ski-navbar-item class="page-navbar-item" to="/cours/" :active="$route.path.startsWith('/cours')">
            <ski-icon icon="bookmark-fill" /> Liste des cours
          </ski-navbar-item>
          <ski-navbar-item class="page-navbar-item" to="/a-propos/" :active="$route.path === '/a-propos/'">
            <ski-icon icon="pencil-fill" /> À propos
          </ski-navbar-item>
          <ski-navbar-item class="page-navbar-item d-lg-none" to="/cours/" data-bs-toggle="modal" data-bs-target="#modal-lesson-list">
            <ski-icon icon="tag-fill" /> Accès direct à un cours
          </ski-navbar-item>
        </ski-navbar-items>
        <navbar-brand class="desktop-navbar-brand" />
        <ski-navbar-items class="d-none d-lg-block ms-auto">
          <lesson-list-dropdown class="page-navbar-item" />
        </ski-navbar-items>
        <template #brand>
          <navbar-brand class="mobile-navbar-brand" />
        </template>
      </ski-navbar-collapse>
    </ski-navbar>
    <lesson-list-modal />
  </div>
</template>

<script>
import { SkiIcon, SkiNavbar, SkiNavbarCollapse, SkiNavbarItem, SkiNavbarItems } from 'skimple-components'
import NavbarBrand from '~/components/PageNavbar/NavbarBrand'
import LessonListModal from '~/components/PageNavbar/LessonListModal'
import LessonListDropdown from '~/components/PageNavbar/LessonListDropdown'

export default {
  components: { LessonListDropdown, LessonListModal, NavbarBrand, SkiNavbar, SkiNavbarCollapse, SkiNavbarItems, SkiNavbarItem, SkiIcon },
  data () {
    return {
      heightDelta: 0,
      currentTopOffset: 0
    }
  },
  watch: {
    currentTopOffset (value) {
      this.$refs.navbar.$el.classList.toggle('shrinked', value > this.heightDelta)
    }
  },
  async mounted () {
    await this.$nextTick()

    const navbar = this.$refs.navbar.$el
    const fullHeight = 130
    const shrinkedHeight = 70

    navbar.setAttribute('style', `--height: ${fullHeight}px; --shrinked-height: ${shrinkedHeight}px`)
    navbar.setAttribute('data-height', fullHeight.toString())
    navbar.setAttribute('data-shrinked-height', shrinkedHeight.toString())
    const spacer = document.createElement('div')
    spacer.classList.add('bg-primary')
    spacer.setAttribute('id', 'page-navbar-spacer')
    spacer.style.height = `${fullHeight}px`

    navbar.parentNode.insertBefore(spacer, navbar)

    document.documentElement.scrollTop = Math.max(document.documentElement.scrollTop - fullHeight, 0)

    this.heightDelta = fullHeight - shrinkedHeight
  },
  beforeMount () {
    window.addEventListener('scroll', this.handleScroll)
  },
  beforeUnmount () {
    window.removeEventListener('scroll', this.handleScroll)
  },
  methods: {
    handleScroll () {
      this.currentTopOffset = document.documentElement.scrollTop
    }
  }
}
</script>

<style lang="scss" scoped>
@import 'assets/bootstrap-mixins';
@import 'assets/colors';

$shrinked-shadow: 0 0 20px rgba(black, 0.2);

#page-navbar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 3;
  background-color: $primary !important;
  transition: all 300ms;
  height: var(--height);

  &:deep(#page-navbar-collapse) {
    position: relative;

    &.collapsing, &.show {
      margin-left: -40px;
      margin-right: -40px;
      // box-shadow: $shrinked-shadow;
    }

    @include media-breakpoint-up(lg) {
      .page-navbar-item {
        position: relative;

        &:before {
          position: absolute;
          content: '';
          height: 2px;
          background-color: white;
          bottom: 4px;
          left: 50%;
          right: 50%;
          opacity: 0.75;
          transition: all 500ms;
        }

        &:hover:before {
          left: 8px;
          right: 8px;
        }
      }
    }

    @include media-breakpoint-down(lg) {
      .page-navbar-item {
        padding: 10px 20px;
        background-color: darken($primary, 5%);

        :deep(a) {
          padding: 10px;
        }
      }
    }
  }

  &.shrinked {
    box-shadow: $shrinked-shadow;
    padding-top: 5px;
    padding-bottom: 5px;
    background-color: darken($primary, 10%) !important;
    height: var(--shrinked-height);

    .desktop-navbar-brand {
      font-size: 40px;
    }

    .mobile-navbar-brand {
      font-size: 30px;
    }
  }

  .desktop-navbar-brand {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    font-size: 60px;

    @include media-breakpoint-down(xl) {
      display: none;
    }
  }

  .mobile-navbar-brand {
    flex: 1;
    font-size: 60px;

    @include media-breakpoint-up(lg) {
      display: none;
    }
  }
}
</style>
