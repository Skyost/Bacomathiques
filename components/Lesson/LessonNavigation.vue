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

      <ul
        v-if="entry.children.length > 0"
        :ref="entry.section"
        class="collapse children"
        :class="{ show: activeEntry.section === entry.section }"
      >
        <li
          v-for="child in entry.children"
          :key="child.id"
        >
          <a
            :href="`#${child.id}`"
            class="entry child"
            :class="{ active: child.id === activeEntry.id }"
            v-html="child.html"
          />
        </li>
      </ul>
    </div>
  </nav>
</template>

<script>
// import { ResizeObserver } from '@juggle/resize-observer'

export default {
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
    if (process.client) {
      await this.$nextTick()

      this.resizeObserver = new ResizeObserver(this.refreshEntries)
      this.resizeObserver.observe(document.body)

      const top = document.getElementById('page-navbar').getAttribute('data-shrinked-height')
      this.$el.style.top = `${top}px`
    }
  },
  beforeMount () {
    window.addEventListener('scroll', this.handleScroll)
  },
  beforeUnmount () {
    window.removeEventListener('scroll', this.handleScroll)
    this.resizeObserver?.disconnect()
  },
  methods: {
    refreshEntries () {
      this.entries = this.toc.map(this.tocEntryToNavigationEntry)
    },
    tocEntryToNavigationEntry (tocEntry, section = null) {
      if (tocEntry.depth === 2) {
        section = tocEntry.id
      }

      const result = {
        id: tocEntry.id,
        html: tocEntry.text,
        children: [],
        section
      }

      const htmlElement = document.getElementById(tocEntry.id)
      if (htmlElement) {
        result.html = htmlElement.querySelector('.toc-content').innerHTML
        result.topOffset = this.getAbsoluteTopOffset(htmlElement) - htmlElement.offsetHeight
      }

      if (tocEntry.children) {
        for (const child of tocEntry.children) {
          result.children.push(this.tocEntryToNavigationEntry(child, section))
        }
      }

      return result
    },
    getMaxAcceptableEntry (topOffset, entries) {
      let maxAcceptableEntry = null
      for (const entry of entries) {
        if (topOffset < entry.topOffset) {
          break
        }
        maxAcceptableEntry = this.getMaxAcceptableEntry(topOffset, entry.children) ?? entry
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
  counter-reset: headline-2 headline-3;

  .entry {
    color: $body-color;
    text-decoration: none;
    display: block;
    position: relative;
    padding-left: 20px;

    &.active,
    &.show {
      font-weight: bold;
      color: $primary;

      &::after {
        background-color: $primary;
      }
    }

    &.parent {
      counter-increment: headline-2;
      counter-reset: headline-3;

      &::before {
        content: counter(headline-2, upper-roman) ' – '
      }
    }

    &.child {
      padding-left: 40px;
      counter-increment: headline-3;

      &::before {
        content: counter(headline-3) '. '
      }
    }

    &::after {
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
