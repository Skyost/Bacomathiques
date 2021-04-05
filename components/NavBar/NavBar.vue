<template>
  <b-navbar id="page-navbar" toggleable="lg" type="dark">
    <b-navbar-toggle target="nav-collapse" />
    <b-navbar-brand class="d-lg-none d-block">
      <logo to="/" />
    </b-navbar-brand>
    <b-collapse id="nav-collapse" is-nav class="row">
      <b-col cols="12" lg="6" xl="4">
        <b-navbar-nav>
          <nav-bar-item v-for="item in items" :key="item.id" :to="item.href">
            <b-icon :icon="item.icon" /> {{ item.title }}
          </nav-bar-item>
        </b-navbar-nav>
      </b-col>
      <b-col xl="4" class="d-xl-block d-none">
        <logo to="/" />
      </b-col>
      <b-col lg="6" xl="4" class="d-md-block d-none">
        <b-navbar-nav>
          <lesson-list-dropdown />
        </b-navbar-nav>
      </b-col>
      <b-col cols="12" class="d-md-none d-block">
        <b-navbar-nav>
          <nav-bar-item v-b-modal.modal-lesson-list>
            <b-icon-tag-fill /> Accès direct à un cours
          </nav-bar-item>
        </b-navbar-nav>
        <lesson-list-modal />
      </b-col>
    </b-collapse>
  </b-navbar>
</template>

<script>
import { BIcon, BIconHouseDoorFill, BIconBookmarkFill, BIconPencilFill, BIconTagFill } from 'bootstrap-vue'
import Logo from '../Logo'
import NavBarItem from './NavBarItem'
import LessonListDropdown from './LessonListDropdown/LessonListDropdown'
import LessonListModal from './LessonListModal'

export default {
  name: 'NavBar',
  // eslint-disable-next-line vue/no-unused-components
  components: { LessonListModal, BIcon, BIconHouseDoorFill, BIconBookmarkFill, BIconPencilFill, BIconTagFill, LessonListDropdown, Logo, NavBarItem },
  data () {
    return {
      items: [
        {
          id: 'home',
          href: '/',
          title: 'Accueil',
          icon: 'house-door-fill'
        },
        {
          id: 'lessons',
          href: '/cours/',
          title: 'Liste des cours',
          icon: 'bookmark-fill'
        },
        {
          id: 'about',
          href: '/a-propos/',
          title: 'À propos',
          icon: 'pencil-fill'
        }
      ],
      heightDelta: 0,
      currentTopOffset: 0
    }
  },
  watch: {
    currentTopOffset (value) {
      this.$el.classList.toggle('shrinked', value > this.heightDelta)
    }
  },
  async mounted () {
    await this.$nextTick()

    const navbar = this.$el
    const fullHeight = 130
    const shrinkedHeight = 70

    navbar.setAttribute('style', `--height: ${fullHeight}px; --shrinked-height: ${shrinkedHeight}px`)
    navbar.setAttribute('data-height', fullHeight.toString())
    navbar.setAttribute('data-shrinked-height', shrinkedHeight.toString())
    const spacer = document.createElement('div')
    spacer.setAttribute('id', 'page-navbar-spacer')
    spacer.style.height = `${fullHeight}px`

    navbar.parentNode.insertBefore(spacer, navbar)

    document.documentElement.scrollTop = Math.max(document.documentElement.scrollTop - fullHeight, 0)

    this.heightDelta = fullHeight - shrinkedHeight
  },
  beforeMount () {
    window.addEventListener('scroll', this.handleScroll)
  },
  beforeDestroy () {
    window.removeEventListener('scroll', this.handleScroll)
  },
  methods: {
    handleScroll () {
      this.currentTopOffset = document.documentElement.scrollTop
    }
  }
}
</script>

<style lang="scss">
@import 'assets/breakpoints';
@import 'assets/colors';

#page-navbar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 2;
  background-color: $main-color;
  padding: 20px 40px;
  font-weight: bold;
  transition: all 300ms;
  height: var(--height);

  .logo {
    display: table;
    margin: auto;
    font-size: 60px;
    text-align: center;

    @media (max-width: $tablet-width) {
      font-size: 30px !important;
    }
  }

  .nav-link {
    position: relative;

    &::before {
      position: absolute;
      content: '';
      height: 2px;
      background-color: white;
      bottom: 4px;
      left: 50%;
      right: 50%;
      opacity: 0.75;
      transition: all 500ms;

      @media (max-width: $tablet-width) {
        height: 1.5px;
        left: 0;
        right: 100%;
      }
    }

    &:hover::before {
      left: 8px;
      right: 8px;

      @media (max-width: $tablet-width) {
        left: 0;
        right: 0;
      }
    }
  }

  .nav-item.active.nav-link::before {
    opacity: 1;
    left: 8px;
    right: 8px;

    @media (max-width: $tablet-width) {
      left: 0;
      right: 0;
    }
  }

  .dropdown-menu {
    height: auto;
    max-height: 75vh;
    overflow-y: auto;

    .form-control {
      border: none;
    }

    @media (max-width: $tablet-width) {
      max-height: 300px;
      overflow-x: hidden;
    }

    @media (max-width: $mobile-width) {
      max-width: 60%;
    }
  }

  &.shrinked {
    box-shadow: 0 0 20px rgba(black, 0.2);
    padding-top: 5px;
    padding-bottom: 5px;
    background-color: darken($main-color, 10%);
    height: var(--shrinked-height);

    .logo {
      font-size: 40px;
    }
  }

  @media (max-width: $large-width) {
    height: auto !important;
  }

  @media (max-width: $tablet-width) {
    padding-left: 20px;
    padding-right: 20px;
  }
}

#page-navbar-spacer {
  background-color: $main-color;
}
</style>
