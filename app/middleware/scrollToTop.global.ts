export default defineNuxtRouteMiddleware((to, from) => {
  if (to.path !== from.path && import.meta.client) {
    window.scrollTo(0, 0)
  }
})
