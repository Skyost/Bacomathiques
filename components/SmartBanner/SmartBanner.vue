<script lang="ts">
export type MobileOs = 'Android' | 'iOS' | 'unknown'
</script>

<script setup lang="ts">
import SmartBannerContent from '~/components/SmartBanner/SmartBannerContent'

let expires = new Date()
expires = new Date(expires.setMonth(expires.getMonth() + 6))
const cookie = useCookie('smartbanner_closed', {
  path: '/',
  expires
})

const mobileOs = computed<MobileOs>(() => {
  // @ts-ignore
  const userAgent = navigator.userAgent || navigator.vendor || window.opera
  if (/android/i.test(userAgent)) {
    return 'Android'
  }

  // @ts-ignore
  if (/iPad|iPhone|iPod/.test(userAgent) && !window.MSStream) {
    return 'iOS'
  }

  return 'unknown'
})

const onClose = () => {
  cookie.value = 'true'
}
</script>

<template>
  <smart-banner-content
    v-if="!cookie"
    :mobile-os="mobileOs"
    @close="onClose"
  />
</template>

<style lang="scss" scoped>
.smartbanner {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  z-index: 4;
  padding: 10px 20px;
  max-height: 120px;

  .smartbanner-close {
    font-size: 20px;
    display: block;
    margin-left: auto;
    margin-right: auto;
  }

  .info {
    display: block;
    width: 100%;
  }
}
</style>
