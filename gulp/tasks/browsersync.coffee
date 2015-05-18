config = require('../config')
gulp = require('gulp')
sass = require('gulp-sass')
plumber = require('gulp-plumber')
browserSync = require('browser-sync').create()
reload = browserSync.reload

gulp.task 'browsersync', ->

  browserSync.init({
    server: config.paths.srcPath
    open: false
    files: [
      config.paths.srcPath + config.files.css
      config.paths.srcPath + config.files.html
      config.paths.srcPath + config.filePath.js + config.fileNames.bundlejsFile
    ]
  })
