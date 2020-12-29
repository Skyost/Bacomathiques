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
import SmartBannerContent from './SmartBannerContent'
export default {
  name: 'SmartBanner',
  components: { SmartBannerContent },
  data () {
    return {
      storeName: null,
      storeLink: null,
      bannerClass: null
    }
  },
  mounted () {
    if (this.$cookies.get('smartbanner_closed') ?? false) {
      return
    }

    const mobileOS = this.getMobileOS()
    switch (mobileOS) {
      case 'Android':
        this.storeName = 'Sur Google Play'
        this.storeLink = this.$store.state.googlePlay
        this.bannerClass = 'smartbanner-android'
        break
      case 'iOS':
        this.storeName = 'Sur l\'App Store'
        this.storeLink = this.$store.state.appStore
        this.bannerClass = 'smartbanner-ios'
        break
    }
  },
  methods: {
    getMobileOS () {
      const userAgent = navigator.userAgent || navigator.vendor || window.opera
      if (/windows phone/i.test(userAgent)) {
        return 'Windows Phone'
      }

      if (/android/i.test(userAgent)) {
        return 'Android'
      }

      if (/iPad|iPhone|iPod/.test(userAgent) && !window.MSStream) {
        return 'iOS'
      }

      return 'unknown'
    },
    onClose () {
      let expirationDate = new Date()
      expirationDate = new Date(expirationDate.setMonth(expirationDate.getMonth() + 6))
      this.$cookies.set('smartbanner_closed', true, { expires: expirationDate })
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
  z-index: 3;
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
