import esbuild from 'esbuild'
import { sassPlugin } from 'esbuild-sass-plugin'
import path from 'path'

const bundle = true
const logLevel = (process.env.ESBUILD_LOG_LEVEL ?? 'silent') as esbuild.LogLevel
const watch = typeof process.env.ESBUILD_WATCH === 'string'

const plugins: esbuild.Plugin[] = [
  sassPlugin({
    includePaths: [path.resolve(__dirname, 'node_modules')]
  }) as unknown as esbuild.Plugin
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
  promise
    .then((_result) => {
      process.stdin.on('close', () => {
        process.exit(0)
      })

      process.stdin.resume()
    })
    .catch((e) => {
      console.error(e)
      process.exit(1)
    })
} else {
  promise.catch((e) => {
    console.error(e)
    process.exit(10)
  })
}
