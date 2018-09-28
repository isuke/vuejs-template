CleanWebpackPlugin          = require('clean-webpack-plugin')
FriendlyErrorsWebpackPlugin = require('friendly-errors-webpack-plugin')
fs                          = require('fs')
HtmlWebpackPlugin           = require('html-webpack-plugin')
merge                       = require('webpack-merge')
{{#unitTest}}
nodeExternals               = require('webpack-node-externals')
{{/unitTest}}
path                        = require('path')
VueLoaderPlugin             = require('vue-loader/lib/plugin')
webpack                     = require('webpack')

loader = {}
loader.vuePre = [
  {
    loader: 'vue-pug-lint-loader'
    options: JSON.parse(fs.readFileSync(path.resolve(__dirname, '.pug-lintrc')))
  }
]
loader.pug = ['pug-plain-loader']
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
  { loader: 'vue-style-loader'  , options: sourceMap: true }
  { loader: 'css-loader'        , options: sourceMap: true }
  { loader: 'postcss-loader'    , options: sourceMap: true }
{{#if_eq altCss "scss"}}
  { loader: 'sass-loader'       , options: sourceMap: true }
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
  { loader: 'stylus-loader'     , options: sourceMap: true }
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
        test: /\.pug$/
        oneOf: [
          resourceQuery: /^\?vue/
          use: loader.pug
        ]
      }
      {
        test: /\.js$/
        use: loader.js
        exclude: /node_modules/
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
    new VueLoaderPlugin
    new HtmlWebpackPlugin
      template: path.resolve(__dirname, 'src', 'index_template.html')
    new webpack.ProvidePlugin
      'Vue': 'vue'
      'axios': 'axios'
  ]

module.exports = (env, argv) =>
  mode = if argv? then argv.mode else 'test'

  if mode == 'production'
    merge baseConfig,
      output:
        filename: 'build-[hash].js'
      devtool: '#source-map'
      plugins: [
        new CleanWebpackPlugin(['dist'])
        new webpack.LoaderOptionsPlugin
          minimize: true
      ]
  else if mode == 'development'
    merge baseConfig,
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
  {{#unitTest}}
  else if mode == 'test'
    merge baseConfig,
      mode: 'production'
      externals: [nodeExternals()]
      devtool: 'inline-cheap-module-source-map'
  {{/unitTest}}
  else
    console.error "`#{mode}` is not defined."
