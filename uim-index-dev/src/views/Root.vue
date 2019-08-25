<template>
    <div class="title pure-g">
        <div class="pure-u-1 pure-u-xl-1-2 title-left">
            <h1>{{routermsg.appname}}</h1>
            <span>{{routermsg.hitokoto}}</span>
            <router-link class="button-index" to="/auth/login">ログイン</router-link>
            <router-link class="button-index" to="/auth/register">新規登録</router-link>
            <router-link class="button-index" to="/user/panel">アカウント設定</router-link>
        </div>
        <div class="pure-u-xl-1-2 logo-bg">
            <img src="/images/logo_white.png" alt="" class="logo">
        </div>
    </div>
</template>

<script>
export default {
  props: ['routermsg']
}
</script>
