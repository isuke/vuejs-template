path = require('path')
webpack = require('webpack')

loader = {}
loader.coffee = ['babel-loader', 'coffee-loader']
loader.stylus = [
  { loader: 'style-loader'  , options: sourceMap: true }
  { loader: 'css-loader'    , options: sourceMap: true }
  { loader: 'postcss-loader', options: sourceMap: true }
  { loader: 'stylus-loader' , options: sourceMap: true }
  {
    loader: 'stylus-resources-loader'
    options:
      resources: [
        path.resolve(__dirname, './src/styles/_variables.styl')
        path.resolve(__dirname, './src/styles/_mixins.styl')
      ]
  }
]

module.exports =
  entry: './src/main.js'
  output:
    path: path.resolve(__dirname, './dist')
    publicPath: '/dist/'
    filename: 'build.js'
  module:
    rules: [
      {
        test: /\.vue$/
        use:
          loader: 'vue-loader'
          options:
            loaders:
              coffee: loader.coffee
              stylus: loader.stylus
      }
      {
        test: /\.(png|jpg|gif|svg)$/
        use: [
          {
            loader: 'file-loader'
            options:
              name: '[name].[ext]?[hash]'
          }
        ]
      }
      {
        test: /\.coffee$/
        use: loader.coffee
      }
      {
        test: /\.styl$/
        use: loader.stylus
      }
    ]
  resolve:
    alias:
      'vue$': 'vue/dist/vue.esm.js'
  devServer:
    historyApiFallback: true
    noInfo: true
  performance:
    hints: false
  devtool: '#eval-source-map'
  plugins: [
    new webpack.ProvidePlugin
      axios: 'axios'
  ]

if process.env.NODE_ENV == 'production'
  module.exports.devtool = '#source-map'
  # http://vue-loader.vuejs.org/en/workflow/production.html
  module.exports.plugins = (module.exports.plugins || []).concat [
    new webpack.DefinePlugin
      'process.env':
        NODE_ENV: "production"
  ,
    new webpack.optimize.UglifyJsPlugin
      sourceMap: true
      compress:
        warnings: false
  ,
    new webpack.LoaderOptionsPlugin
      minimize: true
  ]
