path = require('path')
webpack = require('webpack')

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
              coffee: ['babel-loader', 'coffee-loader']
              stylus: [
                {
                  loader: 'style-loader'
                  options: sourceMap: true
                }
                {
                  loader: 'css-loader'
                  options: sourceMap: true
                }
                {
                  loader: 'postcss-loader'
                  options: sourceMap: true
                }
                {
                  loader: 'stylus-loader'
                  options: sourceMap: true
                }
              ]
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
        use: [
          {
            loader: 'babel-loader'
          }
          {
            loader: 'coffee-loader'
          }
        ]
      }
      {
        test: /\.styl$/
        use: [
          {
            loader: 'style-loader'
            options: sourceMap: true
          }
          {
            loader: 'css-loader'
            options: sourceMap: true
          }
          {
            loader: 'postcss-loader'
            options: sourceMap: true
          }
          {
            loader: 'stylus-loader'
            options: sourceMap: true
          }
        ]
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
