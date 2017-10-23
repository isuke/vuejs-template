import Vue       from 'vue';
import VueRouter from 'vue-router';

Vue.config.debug         = process.env.NODE_ENV == 'development'
Vue.config.devtools      = process.env.NODE_ENV == 'development'
Vue.config.productionTip = process.env.NODE_ENV == 'development'
Vue.config.silent        = process.env.NODE_ENV != 'development'

Vue.use(VueRouter);

require('@styles/_bases.styl');

const router = new VueRouter({
  routes: require('./routes.coffee')
});

new Vue({
  el: '#app',
  router: router
});
