/* eslint-disable @typescript-eslint/no-var-requires */
import type { PluginBuild, Plugin, LogLevel } from 'esbuild'

const esbuild = require('esbuild') as PluginBuild['esbuild']
const { sassPlugin } = require('esbuild-sass-plugin')
const path = require('path')

const bundle = true
const logLevel = (process.env.ESBUILD_LOG_LEVEL ?? 'silent') as LogLevel
const watch = typeof process.env.ESBUILD_WATCH === 'string'

const plugins: Plugin[] = [
  sassPlugin({
    includePaths: [path.resolve(__dirname, 'node_modules')]
  }) as unknown as Plugin
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
