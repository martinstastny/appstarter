config = require('../config')
gulp = require('gulp')
browserify = require('browserify')
browserSync = require('browser-sync')
reload = browserSync.reload
buffer = require('vinyl-buffer')
source = require('vinyl-source-stream')
plumber = require('gulp-plumber')
coffeeify = require('coffeeify')
watchify = require('watchify')
sourcemaps = require('gulp-sourcemaps')
uglify = require('gulp-uglify')
gutil = require('gulp-util')
_ = require('lodash')

browserifyOpts =
  debug: true
  extensions: ['.coffee', '.hbs']
  entries: ['./src/coffee/app.coffee']

## On error handler
onError = (err) ->
  gutil.beep()
  gutil.log(gutil.colors.yellow(err.toString()))
  this.emit('end')

prepareBundle = (watch) ->
  opts = _.assign({}, watchify.args, browserifyOpts)

  if watch
    b = watchify(browserify(opts))
  else
    b = browserify(opts)

  b.transform(coffeeify)

  b.on('log', gutil.log)
  b.on('error', gutil.log)

  b.on 'update', ->
    makeBundle(b)

  makeBundle(b)

makeBundle = (b) ->
  b.bundle()
  .on('error', onError)
  .pipe(source(config.fileNames.bundlejsFile))
  .pipe(buffer())
  .pipe(uglify())
  .pipe(gulp.dest(config.paths.srcPath + config.filePath.js))
  .pipe(reload({stream: true, once: true}))


## Use for watch task ##
gulp.task 'browserify', ->
  prepareBundle(true)

## Use when building without watcher ##
gulp.task 'browserifybuild', ->
  prepareBundle(false)