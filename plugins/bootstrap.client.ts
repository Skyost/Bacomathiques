import collapse from 'bootstrap/js/dist/collapse'
import modal from 'bootstrap/js/dist/modal'
import carousel from 'bootstrap/js/dist/carousel'
import dropdown from 'bootstrap/js/dist/dropdown'

export default defineNuxtPlugin(nuxtApp => nuxtApp.provide('bootstrap', { collapse, modal, carousel, dropdown }))
