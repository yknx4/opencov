const esbuild = require('esbuild')
const { sassPlugin } = require('esbuild-sass-plugin')
const path = require('path')

const bundle = true
const logLevel = process.env.ESBUILD_LOG_LEVEL || 'silent'
const watch = !!process.env.ESBUILD_WATCH

const plugins = [
  sassPlugin({
    includePaths: [path.resolve(__dirname, 'node_modules')]
  })
]

const promise = esbuild.build({
  entryPoints: ['js/index.ts'],
  bundle,
  target: 'es2016',
  plugins,
  outdir: '../priv/static/assets',
  logLevel,
  watch,
  loader: {
    '.eot': 'file',
    '.woff': 'file',
    '.woff2': 'file',
    '.svg': 'file',
    '.ttf': 'file'
  }
})

if (watch) {
  promise.then((_result) => {
    process.stdin.on('close', () => {
      process.exit(0)
    })

    process.stdin.resume()
  })
}
