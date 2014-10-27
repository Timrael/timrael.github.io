'use strict'

gulp = require 'gulp'
coffee = require 'gulp-coffee'
rename = require 'gulp-rename'
sass = require 'gulp-sass'
postcss = require 'gulp-postcss'
autoprefixer = require 'autoprefixer-core'

uglify = require 'gulp-uglify'
cssmin = require 'gulp-cssmin'
imagemin = require 'gulp-imagemin'

newer = require 'gulp-newer'

paths =
  src:
    css: 'src/styles/**/*.scss'
    js: 'src/scripts/**/*.coffee'
    img: 'src/img/*'
    html: 'src/index.html'
    vendor: 'src/vendor/**/*'
  public:
    css: 'public/css/'
    js: 'public/js/'
    img: 'public/img'
    html: 'public/'
    vendor: 'public/vendor/'

gulp.task 'watch', ->
  gulp.watch paths.src.js, ['js']
  gulp.watch paths.src.css, ['css']

gulp.task 'css', ->
  gulp.src paths.src.css
    .pipe sass()
    .pipe postcss [autoprefixer { browsers: ['last 2 version'] }]
    .pipe gulp.dest paths.public.css

gulp.task 'js', ->
  gulp.src paths.src.js
    .pipe coffee {bare: true}
    .pipe gulp.dest paths.public.js

gulp.task 'img', ->
  gulp.src paths.src.img
    .pipe newer paths.public.img
    .pipe imagemin {optimizationLevel: 5}
    .pipe gulp.dest paths.public.img

gulp.task 'vendor', ->
  gulp.src paths.src.vendor
    .pipe gulp.dest paths.public.vendor

gulp.task 'html', ->
  gulp.src paths.src.html
    .pipe gulp.dest paths.public.html

gulp.task 'default', ['css', 'js', 'img', 'html', 'vendor']

