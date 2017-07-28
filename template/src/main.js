import Vue       from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter);

const router = new VueRouter({
  routes: require('./routes.coffee')
});

new Vue({
  el: '#app',
  router: router
});
