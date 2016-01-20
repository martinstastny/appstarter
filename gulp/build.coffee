gulp = require('gulp')
runSequence = require('run-sequence')

gulp.task 'build', ->
  runSequence('clean', 'styles', 'minifycss', 'coffee', 'browserifybuild', 'imagemin')
