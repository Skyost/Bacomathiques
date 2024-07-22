<script lang="ts">
export const shrinkedHeight = 70
</script>

<script setup lang="ts">
import type { ComponentPublicInstance } from 'vue'
import NavbarBrand from '~/components/Page/Navbar/NavbarBrand.vue'
import LessonListDropdown from '~/components/Page/Navbar/LessonListDropdown.vue'
import LessonList from '~/components/Page/Navbar/LessonList.vue'

const heightDelta = ref<number>(0)
const modelOpened = ref<boolean>(false)

const navbar = ref<ComponentPublicInstance | null>(null)

onMounted(async () => {
  await nextTick()
  handleResize()
})

onBeforeMount(() => {
  window.addEventListener('resize', handleResize)
  window.addEventListener('scroll', handleScroll)
})
onBeforeUnmount(() => {
  window.removeEventListener('resize', handleResize)
  window.removeEventListener('scroll', handleScroll)
})

const handleResize = () => {
  const windowsWidth = window.innerWidth
  const fullHeight = windowsWidth < 768 ? 70 : 130
  navbar.value!.$el.setAttribute('style', `--height: ${fullHeight}px; --shrinked-height: ${shrinkedHeight}px`)
  let spacer = document.getElementById('page-navbar-spacer')
  if (!spacer) {
    spacer = document.createElement('div')
    spacer.classList.add('bg-primary')
    spacer.setAttribute('id', 'page-navbar-spacer')
    navbar.value!.$el.parentNode.insertBefore(spacer, navbar.value!.$el)
  }
  spacer.style.height = `${fullHeight}px`
  document.documentElement.scrollTop = Math.max(document.documentElement.scrollTop - fullHeight, 0)
  heightDelta.value = fullHeight - shrinkedHeight
}

const handleScroll = () => {
  const scrollTop = document.documentElement.scrollTop
  navbar.value?.$el.classList.toggle('shrinked', scrollTop > heightDelta.value)
}
</script>

<template>
  <div>
    <b-navbar
      id="page-navbar"
      ref="navbar"
      v-b-color-mode="'dark'"
      toggleable="lg"
      data-bs-theme="dark"
      variant="primary"
    >
      <navbar-brand class="mobile-navbar-brand" />
      <b-navbar-toggle target="page-navbar-collapse" />
      <b-collapse
        id="page-navbar-collapse"
        is-nav
      >
        <b-navbar-nav class="ms-auto ms-lg-0">
          <b-nav-item
            class="page-navbar-item"
            to="/"
            :active="$route.path === '/'"
          >
            <icon name="bi:house-door-fill" /> Accueil
          </b-nav-item>
          <b-nav-item
            class="page-navbar-item"
            to="/cours/"
            :active="$route.path.startsWith('/cours')"
          >
            <icon name="bi:bookmark-fill" /> Liste des cours
          </b-nav-item>
          <b-nav-item
            class="page-navbar-item"
            to="/a-propos/"
            :active="$route.path === '/a-propos/'"
          >
            <icon name="bi:pencil-fill" /> À propos
          </b-nav-item>
          <b-nav-item
            class="page-navbar-item d-lg-none"
            to="/cours/"
            @click="modelOpened = !modelOpened"
          >
            <icon name="bi:tag-fill" /> Accès direct à un cours
          </b-nav-item>
        </b-navbar-nav>
        <navbar-brand class="desktop-navbar-brand" />
        <b-navbar-nav class="d-none d-lg-block ms-auto">
          <lesson-list-dropdown
            id="lesson-list-dropdown"
            class="page-navbar-item"
          />
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
    <b-modal
      id="modal-lesson-list"
      v-model="modelOpened"
      title="Accès direct à un cours"
      size="lg"
      ok-variant="secondary"
      ok-title="Fermer"
      ok-only
    >
      <client-only>
        <lesson-list />
      </client-only>
    </b-modal>
  </div>
</template>

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
      background-color: darken($primary, 5%);

      .page-navbar-item {
        padding: 10px 20px;

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

      @include media-breakpoint-down(sm) {
        font-size: 24px;
      }
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

    @include media-breakpoint-down(xs) {
      font-size: 50px;
    }

    @include media-breakpoint-down(sm) {
      font-size: 24px;
    }
  }
}

#modal-lesson-list {
  :deep(ul) {
    margin-bottom: 0;
    padding-top: 14px;
  }

  :deep(li) {
    max-width: 100%;

    &.dropdown-header {
      color: rgba(black, 0.6);
    }

    a {
      padding: 10px 4px;
      transition: all 200ms;
      text-overflow: ellipsis;
      white-space: nowrap;
      overflow: hidden;

      &:active {
        color: white;
        background-color: $primary;
      }
    }
  }
}
</style>
