config = require('../config')
gulp = require('gulp')
sass = require('gulp-sass')
browserSync = require('browser-sync')
reload  = browserSync.reload

# Watch task
gulp.task 'watch', ['browserify', 'browsersync'] , ->
  gulp.watch(config.paths.srcPath + config.files.sass, ['styles'])
  gulp.watch(config.paths.srcPath + config.files.coffee, ['coffee'])
  gulp.watch(config.paths.srcPath + config.files.html).on('change', reload)
  return