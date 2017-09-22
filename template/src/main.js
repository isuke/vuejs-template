import Vue       from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter);

require('./styles/_bases.styl');

const router = new VueRouter({
  routes: require('./routes.coffee')
});

new Vue({
  el: '#app',
  router: router
});
