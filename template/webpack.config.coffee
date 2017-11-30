path = require('path')
webpack = require('webpack')
merge = require('webpack-merge')
HtmlWebpackPlugin = require('html-webpack-plugin')
CleanWebpackPlugin = require('clean-webpack-plugin')

loader = {}
loader.coffee = ['babel-loader', 'coffee-loader']
loader.css    = [
  { loader: 'style-loader'  , options: sourceMap: true }
  { loader: 'css-loader'    , options: sourceMap: true }
  { loader: 'postcss-loader', options: sourceMap: true }
]
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

baseConfig =
  entry: './src/main.js'
  output:
    path: path.resolve(__dirname, './dist')
    publicPath: ''
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
        test: /\.css$/
        use: loader.css
      }
      {
        test: /\.styl$/
        use: loader.stylus
      }
    ]
  resolve:
    alias:
      '@src':        path.resolve(__dirname, 'src')
      '@scripts':    path.resolve(__dirname, 'src', 'scripts')
      '@components': path.resolve(__dirname, 'src', 'components')
      '@pages':      path.resolve(__dirname, 'src', 'pages')
      '@assets':     path.resolve(__dirname, 'src', 'assets')
      '@styles':     path.resolve(__dirname, 'src', 'styles')
      'vue$': 'vue/dist/vue.esm.js'
  plugins: [
    new HtmlWebpackPlugin
      template: path.resolve(__dirname, 'src', 'index_template.html')
    new webpack.DefinePlugin
      'process.env':
        NODE_ENV: "'#{process.env.NODE_ENV}'"
    new webpack.ProvidePlugin
      'Vue': 'vue'
      '_': 'lodash'
      'axios': 'axios'
  ]

if process.env.NODE_ENV == 'production'
  config = merge baseConfig,
    output:
      filename: 'build-[hash].js'
    devtool: '#source-map'
    plugins: [
      new CleanWebpackPlugin(['dist'])
      new webpack.optimize.UglifyJsPlugin
        sourceMap: true
        compress:
          warnings: false
      new webpack.LoaderOptionsPlugin
        minimize: true
    ]
else
  config = merge baseConfig,
    output:
      filename: 'build.js'
    devtool: '#eval-source-map'
    devServer:
      contentBase: 'dist'
      historyApiFallback: true
      noInfo: true
    performance:
      hints: false

module.exports = config
