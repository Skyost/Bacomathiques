import * as bootstrapCollapse from 'bootstrap/js/dist/collapse'
import * as bootstrapModal from 'bootstrap/js/dist/modal'
import * as bootstrapCarousel from 'bootstrap/js/dist/carousel'
import * as bootstrapDropdown from 'bootstrap/js/dist/dropdown'
import { defineNuxtPlugin } from '#app'

export default defineNuxtPlugin((nuxtApp) => {
  nuxtApp.provide('bootstrap', {
    ...bootstrapCollapse,
    ...bootstrapModal,
    ...bootstrapCarousel,
    ...bootstrapDropdown
  })
})
