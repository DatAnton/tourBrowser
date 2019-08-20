const { dev_server: devServer } = require('@rails/webpacker').config

const isProduction = process.env.NODE_ENV === 'production'
const inDevServer = process.argv.find(v => v.includes('webpack-dev-server'))
const extractCSS = !(inDevServer && (devServer && devServer.hmr)) || isProduction


module.exports = {
  test: /\.vue(\.erb)?$/,
  use: [{
    loader: 'vue-loader',
    options: { extractCSS }
  }],
  resolve: {
    alias: {
      // If using the runtime only build
      // vue$: 'vue/dist/vue.runtime.esm.js' // 'vue/dist/vue.runtime.common.js' for webpack 1
      // Or if using full build of Vue (runtime + compiler)
      vue$: 'vue/dist/vue.esm.js'      // 'vue/dist/vue.common.js' for webpack 1
    }
  }
}
