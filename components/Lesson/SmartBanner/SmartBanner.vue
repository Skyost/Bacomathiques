<template>
  <smart-banner-content
    v-if="storeName && storeLink"
    :class="bannerClass"
    :store-name="storeName"
    :store-link="storeLink"
    @close="onClose"
  />
</template>

<script>
import Cookie from 'cookie-universal'
import SmartBannerContent from '~/components/Lesson/SmartBanner/SmartBannerContent'
import site from '~/site'

export default {
  components: { SmartBannerContent },
  data () {
    return {
      storeName: null,
      storeLink: null,
      bannerClass: null
    }
  },
  computed: {
    mobileOS () {
      const userAgent = navigator.userAgent || navigator.vendor || window.opera
      if (/android/i.test(userAgent)) {
        return 'Android'
      }

      if (/iPad|iPhone|iPod/.test(userAgent) && !window.MSStream) {
        return 'iOS'
      }

      return 'unknown'
    }
  },
  mounted () {
    const cookie = Cookie()
    if (!cookie.get('smartbanner_closed')) {
      return
    }

    const mobileOS = this.mobileOS
    switch (mobileOS) {
      case 'Android':
        this.storeName = 'Sur Google Play'
        this.storeLink = site.mobile.googlePlay
        this.bannerClass = 'smartbanner-android'
        break
      case 'iOS':
        this.storeName = 'Sur l\'App Store'
        this.storeLink = site.mobile.appStore
        this.bannerClass = 'smartbanner-ios'
        break
    }
  },
  methods: {
    onClose () {
      const cookie = Cookie()
      let expires = new Date()
      expires = new Date(expires.setMonth(expires.getMonth() + 6))
      cookie.set('smartbanner_closed', true, {
        path: '/',
        expires
      })
    }
  }
}
</script>

<style lang="scss">
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
