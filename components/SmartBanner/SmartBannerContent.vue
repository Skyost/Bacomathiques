<script setup lang="ts">
import { site } from '~/site/site'
import type { MobileOs } from '~/components/SmartBanner/SmartBanner.vue'

interface Store {
  name: string
  link: string
  bannerClass: string
}

const props = defineProps<{
  mobileOs: MobileOs
}>()

const emit = defineEmits<{ (e: 'close'): void }>()

const store = ref<Store | null>(null)

onMounted(() => {
  switch (props.mobileOs) {
    case 'Android':
      store.value = {
        name: 'Sur Google Play',
        link: site.mobile.googlePlay,
        bannerClass: 'smartbanner-android'
      }
      break
    case 'iOS':
      store.value = {
        name: 'Sur l\'App Store',
        link: site.mobile.appStore,
        bannerClass: 'smartbanner-ios'
      }
      break
  }
})

const onClose = () => {
  store.value = null
  emit('close')
}
</script>

<template>
  <b-row
    v-if="store"
    class="smartbanner"
    :class="store.bannerClass"
  >
    <b-col
      width="1"
      class="d-flex align-items-center"
    >
      <span
        class="smartbanner-close"
        @click="onClose"
      >&times;</span>
    </b-col>
    <b-col
      width="3"
      class="d-flex align-items-center"
    >
      <img
        src="/img/logo.svg"
        alt="Logo"
        class="w-100"
      >
    </b-col>
    <b-col
      width="5"
      class="d-flex align-items-center"
    >
      <div>
        <span
          class="info info-title"
          v-text="site.name"
        />
        <span class="info info-author">Skyost</span>
        <span class="info info-price">GRATUIT - {{ store.name }}</span>
      </div>
    </b-col>
    <b-col
      width="3"
      class="d-flex align-items-center"
    >
      <b-button
        :href="store.link"
        target="_blank"
        variant="green"
        block
      >
        VOIR
      </b-button>
    </b-col>
  </b-row>
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

.smartbanner-android {
  background: #3d3d3d url('data:image/gif;base64,R0lGODlhCAAIAIABAFVVVf///yH5BAEHAAEALAAAAAAIAAgAAAINRG4XudroGJBRsYcxKAA7');
  color: white;

  .smartbanner-close {
    position: relative;
  }

  .smartbanner-close::before {
    content: '';
    display: inline-block;
    height: 30px;
    width: 30px;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: rgba(black, 0.5);
    border-radius: 100%;
    z-index: -1;
  }

  .info-author,
  .info-price {
    color: rgba(white, 0.75);
  }
}

.smartbanner-ios {
  background: #f3f3f3;

  .info-title {
    font-weight: bold;
  }
}
</style>
