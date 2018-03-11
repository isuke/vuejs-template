//
// Libraries
//
import Vue       from 'vue';
import VueRouter from 'vue-router';

//
// Styles
//
import 'tinyreset/tinyreset.css';
{{#if_eq altCss "scss"}}
import '@styles/_bases.scss';
{{/if_eq}}
{{#if_eq altCss "stylus"}}
import '@styles/_bases.styl';
{{/if_eq}}

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
