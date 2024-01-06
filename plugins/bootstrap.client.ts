import * as collapse from 'bootstrap/js/dist/collapse'
import * as modal from 'bootstrap/js/dist/modal'
import * as carousel from 'bootstrap/js/dist/carousel'
import * as dropdown from 'bootstrap/js/dist/dropdown'

export default defineNuxtPlugin(nuxtApp => nuxtApp.provide('bootstrap', { collapse, modal, carousel, dropdown }))
