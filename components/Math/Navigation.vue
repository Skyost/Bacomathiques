<script setup lang="ts">
import type { Toc, TocEntry } from '~/types'
import { shrinkedHeight } from '~/components/Page/Navbar/PageNavbar.vue'

const props = withDefaults(defineProps<{
  toc: Toc,
  navbarShrinkedHeight?: number
}>(), {
  navbarShrinkedHeight: shrinkedHeight
})

interface NavigationEntry {
  id: string,
  html: string,
  children: NavigationEntry[],
  section: string | null,
  topOffset: number
}

const root = ref<HTMLElement | null>(null)
const activeEntry = ref<NavigationEntry | null>(null)
const entries = ref<NavigationEntry[]>([])
const currentTopOffset = ref<number>(0)
const resizeObserver = ref<ResizeObserver | null>(null)

watch(currentTopOffset, (value) => {
  const maxAcceptableEntry = getMaxAcceptableEntry(value, entries.value)
  if (maxAcceptableEntry != null) {
    activeEntry.value = maxAcceptableEntry
  }
})

onMounted(async () => {
  await nextTick()

  refreshEntries()
  activeEntry.value = entries.value[0]

  await nextTick()

  resizeObserver.value = new ResizeObserver(refreshEntries)
  resizeObserver.value.observe(document.body)

  root.value!.style.top = `${props.navbarShrinkedHeight}px`
})

onBeforeMount(() => {
  window.addEventListener('scroll', handleScroll)
})

onBeforeUnmount(() => {
  window.removeEventListener('scroll', handleScroll)
  resizeObserver.value?.disconnect()
})

const refreshEntries = () => {
  entries.value = props.toc.map((entry: TocEntry) => tocEntryToNavigationEntry(entry))
}

const tocEntryToNavigationEntry = (tocEntry: TocEntry, section: string | null = null): NavigationEntry => {
  if (tocEntry.depth === 2) {
    section = tocEntry.id
  }

  const result: NavigationEntry = {
    id: tocEntry.id,
    html: tocEntry.text,
    children: [],
    topOffset: -1,
    section
  }

  const htmlElement = document.getElementById(tocEntry.id)
  if (htmlElement) {
    const clone = htmlElement.cloneNode(true) as HTMLElement
    const anchor = clone.querySelector('.anchor')
    if (anchor) {
      clone.removeChild(anchor)
    }
    result.html = clone.innerHTML
    result.topOffset = getAbsoluteTopOffset(htmlElement) - htmlElement.offsetHeight
  }

  for (const child of tocEntry.children) {
    result.children.push(tocEntryToNavigationEntry(child, section))
  }

  return result
}

const getMaxAcceptableEntry = (topOffset: number, entries: NavigationEntry[]): NavigationEntry | null => {
  let maxAcceptableEntry = null
  for (const entry of entries) {
    if (topOffset < entry.topOffset) {
      break
    }
    maxAcceptableEntry = getMaxAcceptableEntry(topOffset, entry.children) ?? entry
  }

  return maxAcceptableEntry
}

const handleScroll = () => {
  currentTopOffset.value = document.documentElement.scrollTop
}

const getAbsoluteTopOffset = (element: HTMLElement): number => {
  let top = 0
  let offsetParent: HTMLElement | null = element
  do {
    top += offsetParent.offsetTop || 0
    offsetParent = offsetParent.offsetParent as HTMLElement | null
  } while (offsetParent)
  return top
}
</script>

<template>
  <nav
    v-if="activeEntry"
    ref="root"
    class="lesson-navigation"
  >
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

<style lang="scss" scoped>
@import 'assets/colors';

.lesson-navigation {
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
