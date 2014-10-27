'use strict'

gulp = require 'gulp'
rename = require 'gulp-rename'
uglify = require 'gulp-uglify'
sass = require 'gulp-sass'
autoprefixer = require 'gulp-autoprefixer'
cssmin = require 'gulp-cssmin'

srcPaths =
  scripts: 'src/scripts/**/*.coffee'
  styles: 'src/styles/**/*.scss'

publicPaths =
  scripts: 'public/js/'
  styles: 'public/css/'

gulp.task 'default', ->
  gulp.src('foo.js')
    .pipe(gulp.dest(DEST))
    .pipe(uglify())
    .pipe(rename(extname: '.min.js'))
    .pipe gulp.dest publicPaths.scripts

gulp.task 'watch', ->
#  gulp.watch srcPaths.scripts, ['js']
  gulp.watch srcPaths.styles, ['css']


gulp.task 'css', ->
  gulp.src srcPaths.styles
    .pipe sass()
    .pipe autoprefixer()
    .pipe gulp.dest publicPaths.styles

gulp.task 'js', ->
  gulp.src srcPaths.scripts
    .pipe(coffee({bare: true})).on('error', gutil.log)
    .pipe gulp.dest publicPaths.scripts
