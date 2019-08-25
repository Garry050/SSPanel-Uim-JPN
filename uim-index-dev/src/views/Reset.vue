<template>
  <div class="page-pw pure-u-1 pure-g flex align-center space-around wrap">
    <div class="title-back flex align-center">PASSWORD</div>
    <div class="pure-u-1 pure-u-sm-10-24 flex space-around wrap basis-max">
      <h1>パスワード再設定</h1>
      <div class="input-control flex wrap">
        <label for="Email" class="flex space-between align-center">
          <span>メールアドレス</span>
          <span>
            <router-link class="button-index" to="/auth/login">
              <font-awesome-icon icon="share" />&nbsp;トップに戻る
            </router-link>
          </span>
        </label>
        <input v-model="email" type="text" name="Email">
      </div>
      <button
        @click.prevent="reset"
        @keyup.13.native="reset"
        class="auth-submit"
        id="reset"
        type="submit"
        :disabled="isDisabled"
      >パスワード再設定</button>
    </div>
  </div>
</template>

<script>
import storeMap from '@/mixins/storeMap'
import { _post } from '../js/fetch'

export default {
  mixins: [storeMap],
  data: function () {
    return {
      email: '',
      isDisabled: false
    }
  },
  methods: {
    reset () {
      let callConfig = {
        msg: '',
        icon: '',
        time: 1000
      }

      _post(
        '/password/reset',
        JSON.stringify({
          email: this.email
        }),
        'omit'
      ).then(r => {
        if (r.ret === 1) {
          callConfig.msg += 'パスワード再設定用リンクを送信しました'
          callConfig.icon += 'check-circle'
          this.callMsgr(callConfig)
          window.setTimeout(() => {
            this.$router.push('/auth/login')
          }, this.globalConfig.jumpDelay)
        } else {
          callConfig.msg += 'パスワード再設定用リンクの送信に失敗しました。メールアドレスが正しいか確認してください'
          callConfig.icon += 'times-circle'
          this.callMsgr(callConfig)
          window.setTimeout(() => {
            this.isDisabled = false
          }, 3000)
        }
      })
    }
  }
}
</script>
