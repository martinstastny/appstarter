gulp = require('gulp')
runSequence = require('run-sequence')

gulp.task 'default', ->
  runSequence('styles', 'coffee', 'watch')
