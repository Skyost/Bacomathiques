<template>
  <ski-columns v-if="show" class="smartbanner">
    <ski-column width="1" class="d-flex align-items-center">
      <span class="smartbanner-close" @click="onClose">&times;</span>
    </ski-column>
    <ski-column width="3" class="d-flex align-items-center">
      <img src="/img/logo.svg" alt="Logo" class="w-100">
    </ski-column>
    <ski-column width="5" class="d-flex align-items-center">
      <div>
        <span class="info info-title" v-text="siteName" />
        <span class="info info-author">Skyost</span>
        <span class="info info-price">GRATUIT - {{ storeName }}</span>
      </div>
    </ski-column>
    <ski-column width="3" class="d-flex align-items-center">
      <ski-button
        :href="storeLink"
        target="_blank"
        variant="green"
        block
      >
        VOIR
      </ski-button>
    </ski-column>
  </ski-columns>
</template>

<script>
import siteMeta from '~/site'

export default {
  props: {
    storeName: {
      type: String,
      required: true
    },
    storeLink: {
      type: String,
      required: true
    }
  },
  emits: ['close'],
  data () {
    return {
      show: true
    }
  },
  computed: {
    siteName () {
      return siteMeta.name
    }
  },
  methods: {
    onClose () {
      this.show = false
      this.$emit('close')
    }
  }
}
</script>

<style lang="scss">
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
