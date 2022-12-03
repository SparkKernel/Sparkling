const {resolve} = require('path')
const buildPath = resolve(__dirname, "build")

const {build} = require('esbuild')

build({
    entryPoints: ['./Source/Main.ts'],
    outdir: resolve(buildPath, 'Source'),
    bundle: true,
    minify: true,
    platform: 'browser',
    target: 'es2020',
    logLevel: 'info'
}).catch(() => process.exit(1))