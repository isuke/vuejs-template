<template lang="pug">
.bye
  h1 \{{ msg }}
  router-link(:to="{ name: 'top'}") TOP
</template>

<script lang="coffee">
module.exports = {
  name: 'bye'
  data: ->
    msg: 'Bye'
}
</script>

<style lang="stylus">
.bye {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;

  h1 {
    font-weight: normal;
  }

  a {
    color: #42b983;
  }
}
</style>
