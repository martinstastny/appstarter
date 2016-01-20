config = require('../config')
gulp = require('gulp')
sass = require('gulp-sass')
minify = require('gulp-minify-css')

minifyOpts =
  keepBreaks: false
  keepSpecialComments: false,
  advanced: false

## Minify CSS ##
gulp.task 'minifycss', ->
  gulp.src(config.paths.srcPath + config.filePath.css + '**/*.css')
  .pipe(minify(minifyOpts))
  .pipe(gulp.dest(config.paths.distPath + config.filePath.css))


