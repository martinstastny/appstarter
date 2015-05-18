config = {}

## Base Paths ##
config.paths =
  srcPath: 'src/'
  distPath: 'dist/'
  sourcemaps: './sourcemaps'

## Folder Paths ##
config.filePath =
  sass: 'sass/'
  css: 'css/'
  coffee: 'coffee/'
  js: 'js/'
  jsGenerated: 'js/'

config.fileNames =
  mainjsFile: 'app.coffee' # Browserify sourcefile
  bundlejsFile: 'bundle.js' # Browserify bundlefile

## File Paths ##
config.files =
  sass: config.filePath.sass + '**/*.{sass,scss}'
  coffee: config.filePath.coffee + '**/*.coffee'
  css: config.filePath.css + '*.css'
  js: config.filePath.js + '**/*.js'
  html: '**/*.html'

module.exports = config

