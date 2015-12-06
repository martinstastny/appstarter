config = require('../config')
gulp = require('gulp')
browserify = require('browserify')
browserSync = require('browser-sync')
reload = browserSync.reload
buffer = require('vinyl-buffer')
source = require('vinyl-source-stream')
plumber = require('gulp-plumber')
coffeeify = require('coffeeify')
handlebars = require('browserify-handlebars')
watchify = require('watchify')
sourcemaps = require('gulp-sourcemaps')
uglify = require('gulp-uglify')
gutil = require('gulp-util')
gulpif = require('gulp-if')
_ = require('lodash')


# Define Browserify options
browserifyOpts =
  debug: true
  extensions: ['.coffee', '.hbs']
  entries: ['./' + config.paths.srcPath + config.filePath.coffee + config.fileNames.mainCoffeeFile]
  transform: [coffeeify, handlebars]

buildFlag = false

## On error handler
onError = (err) ->
  gutil.beep()
  gutil.log(gutil.colors.red(err.toString()))
  this.emit('end')

prepareBundle = (watch) ->
  opts = _.assign({}, watchify.args, browserifyOpts)

  if watch
    b = watchify(browserify(opts))
  else
    b = browserify(opts)

  b.on('log', gutil.log)
  b.on('error', gutil.log)

  b.on 'update', ->
    makeBundle(b)

  makeBundle(b)

makeBundle = (b) ->
  b.bundle()
  .on('error', onError)
  .pipe(source('bundle.js'))
  .pipe(buffer())
  .pipe(sourcemaps.init({loadMaps: true}))
  .pipe(gulpif(buildFlag, uglify()))
  .pipe(sourcemaps.write())
  .pipe(gulp.dest(config.paths.srcPath + config.filePath.jsGenerated))
  .pipe(reload({stream: true, once: true}))


## Use for watch task ##
gulp.task 'browserify', ->
  prepareBundle(true)

## Use when building without watcher ##
gulp.task 'browserifybuild', ->
  buildFlag = true
  prepareBundle(false)
