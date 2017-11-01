<template lang="pug">
.top
  img(src='./../assets/logo.png')
  h1 \{{ msg }}
  h2 Essential Links
  ul
    li
      a(href='https://vuejs.org', target='_blank') Core Docs
    li
      a(href='https://forum.vuejs.org', target='_blank') Forum
    li
      a(href='https://gitter.im/vuejs/vue', target='_blank') Gitter Chat
    li
      a(href='https://twitter.com/vuejs', target='_blank') Twitter
  h2 Ecosystem
  ul
    li
      a(href='http://router.vuejs.org/', target='_blank') vue-router
    li
      a(href='http://vuex.vuejs.org/', target='_blank') vuex
    li
      a(href='http://vue-loader.vuejs.org/', target='_blank') vue-loader
    li
      a(href='https://github.com/vuejs/awesome-vue', target='_blank') awesome-vue
  router-link(:to="{ name: 'bye'}") Bye!
</template>

<script lang="coffee" scoped>
export default
  data: ->
    msg: 'Welcome to Your Vue.js App'
</script>

<style lang="stylus">
.top
  -webkit-font-smoothing: antialiased
  -moz-osx-font-smoothing: grayscale
  text-align: center
  margin-top: 60px

  h1, h2
    font-weight: normal

  ul
    list-style-type: none
    padding: 0

  li
    display: inline-block
    margin: 0 10px

  a
    color: #42b983
</style>
