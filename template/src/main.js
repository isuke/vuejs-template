//
// Libraries
//
import Vue       from 'vue';
import VueRouter from 'vue-router';

//
// Styles
//
import 'sanitize.css';
import '@styles/_bases.styl';

//
// Settings
//
Vue.config.debug         = process.env.NODE_ENV == 'development'
Vue.config.devtools      = process.env.NODE_ENV == 'development'
Vue.config.productionTip = process.env.NODE_ENV == 'development'
Vue.config.silent        = process.env.NODE_ENV != 'development'

//
// Vue Router
//
import routes from './routes.coffee'

Vue.use(VueRouter);

const router = new VueRouter({
  routes
});

//
// Vue
//
new Vue({
  el: '#app',
  router: router
});
