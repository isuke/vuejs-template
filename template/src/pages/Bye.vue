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

{{#if_eq altCss "scss"}}
<style lang="scss" scoped>
.bye {
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  margin-top: 60px;

  h1 {
    font-weight: normal;
  }
  a {
    color: #42b983;
  }
}
</style>
{{/if_eq}}
{{#if_eq altCss "stylus"}}
<style lang="stylus" scoped>
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
{{/if_eq}}
