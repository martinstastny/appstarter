config = require('../config')
gulp = require('gulp')
sass = require('gulp-sass')
gutil = require('gulp-util')
plumber = require('gulp-plumber')
sourcemaps = require('gulp-sourcemaps')
browserSync = require('browser-sync')
reload = browserSync.reload

## On error handler
onError = (err) ->
  gutil.beep()
  gutil.log(gutil.colors.yellow(err.message  + err.fileName +  ' on line: ' + err.lineNumber))
  this.emit('end')

## Compiling SASS and SCSS files ##
gulp.task 'styles', ->
  gulp.src(config.paths.srcPath + config.files.sass)
  .pipe(sourcemaps.init())
    .pipe(plumber({ errorHandler: onError}))
    .pipe(sass(indentedSyntax: true, outputStyle:'compressed', errorLogToConsole: true))
  .pipe(sourcemaps.write(config.paths.sourcemaps))
  .pipe(gulp.dest(config.paths.srcPath + config.filePath.css))
  .pipe(reload({stream: true}))
  return

