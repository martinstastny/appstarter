config = require('../config')
gulp = require('gulp')
clean = require('gulp-clean')

### Clean Task ###
gulp.task 'clean', (cb) ->
  gulp.src([config.paths.distPath], {read: false})
  .pipe(clean())