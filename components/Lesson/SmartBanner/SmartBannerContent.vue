<template>
  <b-row v-if="show" class="smartbanner">
    <b-col cols="1" class="d-flex align-items-center">
      <span class="smartbanner-close" @click="onClose">&times;</span>
    </b-col>
    <b-col cols="3" class="d-flex align-items-center">
      <img src="/img/logo.svg" alt="Logo" class="w-100">
    </b-col>
    <b-col cols="5" class="d-flex align-items-center">
      <div>
        <span class="info info-title" v-text="$store.state.siteName" />
        <span class="info info-author">Skyost</span>
        <span class="info info-price">GRATUIT - {{ storeName }}</span>
      </div>
    </b-col>
    <b-col cols="3" class="d-flex align-items-center">
      <b-btn
        :href="storeLink"
        target="_blank"
        variant="success"
        class="btn-green"
        block
      >
        VOIR
      </b-btn>
    </b-col>
  </b-row>
</template>

<script>
export default {
  name: 'SmartBannerContent',
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
  data () {
    return {
      show: true
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
