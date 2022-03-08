<template>
  <nav v-if="activeEntry" id="page-lesson-navigation">
    <div
      v-for="entry in entries"
      :key="entry.id"
    >
      <a
        :href="`#${entry.id}`"
        class="entry parent"
        :class="{'active': entry.id === activeEntry.id}"
        v-html="entry.html"
      />

      <slide-up-down
        v-if="entry.children.length > 0"
        :duration="300"
        :active="activeEntry.section === entry.section"
        tag="ul"
        class="children"
      >
        <li
          v-for="child in entry.children"
          :key="child.id"
        >
          <a
            :href="`#${child.id}`"
            class="entry child"
            :class="{'active': child.id === activeEntry.id}"
            v-html="child.html"
          />
        </li>
      </slide-up-down>
    </div>
  </nav>
</template>

<script>
import SlideUpDown from 'vue-slide-up-down'
import { ResizeObserver } from '@juggle/resize-observer'

export default {
  name: 'LessonNavigation',
  components: { SlideUpDown },
  props: {
    toc: {
      type: Array,
      required: true
    }
  },
  data () {
    return {
      activeEntry: null,
      entries: [],
      currentTopOffset: 0,
      resizeObserver: null
    }
  },
  watch: {
    currentTopOffset (value) {
      const maxAcceptableEntry = this.getMaxAcceptableEntry(value, this.entries)
      if (maxAcceptableEntry != null) {
        this.activeEntry = maxAcceptableEntry
      }
    }
  },
  async mounted () {
    await this.$nextTick()

    this.refreshEntries()
    this.activeEntry = this.entries[0]
    await this.$nextTick()

    this.resizeObserver = new ResizeObserver(this.refreshEntries)
    this.resizeObserver.observe(document.body)

    const top = document.getElementById('page-navbar').getAttribute('data-shrinked-height')
    this.$el.style.top = `${top}px`
  },
  beforeMount () {
    window.addEventListener('scroll', this.handleScroll)
  },
  beforeDestroy () {
    window.removeEventListener('scroll', this.handleScroll)
    this.resizeObserver?.disconnect()
  },
  methods: {
    refreshEntries () {
      const result = []
      let currentDepth2
      for (const entry of this.toc) {
        const element = document.getElementById(entry.id)
        if (!element) {
          continue
        }

        const common = {
          id: entry.id,
          html: entry.html,
          children: [],
          topOffset: this.getAbsoluteTopOffset(element) - element.offsetHeight
        }
        if (entry.depth === 2) {
          currentDepth2 = {
            section: entry.id,
            ...common
          }
          result.push(currentDepth2)
        } else if (entry.depth === 3) {
          currentDepth2.children.push({
            section: currentDepth2.id,
            ...common
          })
        }
      }
      this.entries = result
    },
    getMaxAcceptableEntry (topOffset, entries) {
      let maxAcceptableEntry = null
      for (const entry of entries) {
        if (topOffset >= entry.topOffset) {
          maxAcceptableEntry = this.getMaxAcceptableEntry(topOffset, entry.children) ?? entry
        } else {
          break
        }
      }

      return maxAcceptableEntry
    },
    handleScroll () {
      this.currentTopOffset = document.documentElement.scrollTop
    },
    getAbsoluteTopOffset (element) {
      let top = 0
      do {
        top += element.offsetTop || 0
        element = element.offsetParent
      } while (element)

      return top
    }
  }
}
</script>

<style lang="scss">
@import 'assets/colors';

#page-lesson-navigation {
  background-color: white;
  padding: 40px;
  position: sticky;
  width: 100%;
  z-index: 1;
  box-shadow: 20px 0 30px -10px rgba(black, 0.2);
  font-weight: lighter;

  .entry {
    color: $page-text;
    text-decoration: none;
    display: block;
    position: relative;
    padding-left: 20px;

    &.active {
      font-weight: bold;
      color: $main-color;

      &::before {
        background-color: $main-color;
      }
    }

    &.child {
      padding-left: 40px;
    }

    &::before {
      background-color: #eee;
      content: ' ';
      display: inline-block;
      height: inherit;
      top: 0;
      left: 0;
      bottom: 0;
      position: absolute;
      width: 2px;
    }
  }

  .children {
    padding: 0;
    margin-bottom: 0;
    list-style-type: none;
  }
}
</style>
