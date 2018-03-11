require('jsdom-global')()

global.expect = require('expect')

Vue = require('vue')

Vue.config.debug         = false
Vue.config.devtools      = false
Vue.config.productionTip = false
Vue.config.silent        = true
