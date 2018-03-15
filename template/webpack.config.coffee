fs = require('fs')
path = require('path')
webpack = require('webpack')
merge = require('webpack-merge')
HtmlWebpackPlugin = require('html-webpack-plugin')
CleanWebpackPlugin = require('clean-webpack-plugin')
FriendlyErrorsWebpackPlugin = require('friendly-errors-webpack-plugin')
{{#if unitTest}}
nodeExternals = require('webpack-node-externals')
{{/if}}

loader = {}
loader.vuePre = [
  {
    loader: 'vue-pug-lint-loader'
    options: JSON.parse(fs.readFileSync(path.resolve(__dirname, '.pug-lintrc')))
  }
]
loader.js = ['babel-loader']
loader.coffee = ['babel-loader', 'coffee-loader']
loader.css    = [
  { loader: 'style-loader'  , options: sourceMap: true }
  { loader: 'css-loader'    , options: sourceMap: true }
  { loader: 'postcss-loader', options: sourceMap: true }
]
{{#if_eq altCss "scss"}}
loader.scss = [
{{/if_eq}}
{{#if_eq altCss "stylus"}}
loader.stylus = [
{{/if_eq}}
  { loader: 'style-loader'  , options: sourceMap: true }
  { loader: 'css-loader'    , options: sourceMap: true }
  { loader: 'postcss-loader', options: sourceMap: true }
{{#if_eq altCss "scss"}}
  { loader: 'sass-loader'   , options: sourceMap: true }
  { loader: 'import-glob-loader', options: sourceMap: true }
  {
    loader: 'sass-resources-loader'
    options:
      resources: [
        path.resolve(__dirname, './src/styles/_variables.scss')
        path.resolve(__dirname, './src/styles/_mixins.scss')
      ]
  }
{{/if_eq}}
{{#if_eq altCss "stylus"}}
  { loader: 'stylus-loader' , options: sourceMap: true }
  {
    loader: 'stylus-resources-loader'
    options:
      resources: [
        path.resolve(__dirname, './src/styles/_variables.styl')
        path.resolve(__dirname, './src/styles/_mixins.styl')
      ]
  }
{{/if_eq}}
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
        enforce: "pre"
        exclude: /node_modules/
        use: loader.vuePre
      }
      {
        test: /\.vue$/
        use:
          loader: 'vue-loader'
          options:
            loaders:
              coffee: loader.coffee
              {{#if_eq altCss "scss"}}
              scss: loader.scss
              {{/if_eq}}
              {{#if_eq altCss "stylus"}}
              stylus: loader.stylus
              {{/if_eq}}
      }
      {
        test: /\.(png|jpg|gif|svg)$/
        use: [
          {
            loader: 'file-loader'
            options:
              name: '[name]-[hash].[ext]'
          }
        ]
      }
      {
        test: /\.js$/
        use: loader.js
      }
      {
        test: /\.coffee$/
        use: loader.coffee
      }
      {
        test: /\.css$/
        use: loader.css
      }
      {{#if_eq altCss "scss"}}
      {
        test: /\.scss$/
        use: loader.scss
      }
      {{/if_eq}}
      {{#if_eq altCss "stylus"}}
      {
        test: /\.styl$/
        use: loader.stylus
      }
      {{/if_eq}}
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
else if process.env.NODE_ENV == 'development'
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
    plugins: [
      new FriendlyErrorsWebpackPlugin()
    ]
{{#if unitTest}}
else if process.env.NODE_ENV == 'test'
  config = merge baseConfig,
    externals: [nodeExternals()]
    devtool: 'inline-cheap-module-source-map'
{{/if}}
else
  console.error "`#{process.env.NODE_ENV}` is not defined."

module.exports = config
