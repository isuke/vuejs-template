<template lang="pug">
.bye
  h1 \{{ msg }}
  router-link(:to="{ name: 'top'}") TOP
</template>

<script lang="coffee">
export default
  data: ->
    msg: 'Bye'
</script>

<style lang="stylus">
.bye
  -webkit-font-smoothing: antialiased
  -moz-osx-font-smoothing: grayscale
  text-align: center
  margin-top: 60px

  h1
    font-weight: normal
  a
    color: #42b983
</style>
