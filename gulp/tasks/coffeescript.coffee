config = require('../config')
gulp = require('gulp')
coffee = require('gulp-coffee')
changed = require('gulp-changed')
coffeeify = require('coffeeify')
plumber = require('gulp-plumber')
gutil = require('gulp-util')
sourcemaps = require('gulp-sourcemaps')


## On error handler ##
onError = (err) ->
  gutil.beep()
  gutil.log(gutil.colors.yellow(err.message  + err.fileName +  ' on line: ' + err.lineNumber))
  this.emit('end')


## Compiling CoffeeScript ##
gulp.task 'coffee', ->
  gulp.src(config.paths.srcPath + config.files.coffee)
  .pipe(plumber())
  .pipe(changed(config.paths.srcPath + config.filePath.js, { extension: '.js'}))
  .pipe(sourcemaps.init())
  .pipe(coffee({bare: true})).on 'error', onError
  .pipe(sourcemaps.write(config.paths.sourcemaps))
  .pipe(gulp.dest(config.paths.srcPath + config.filePath.jsGenerated))
  return