spawn = require('child_process').spawn
q = require 'q'
gulp = require 'gulp'
sass = require 'gulp-sass'

util = require 'util'

hpserver = null

gulp.task 'styles', ->
  gulp.src('./app/assets/css/*.scss')
    .pipe(sass())
    .pipe(gulp.dest('./public/css'))

gulp.task 'watch', ->
  gulp.watch('app/assets/css/*.scss',['styles'])
  gulp.watch('app/**/*.coffee',['restart'])

gulp.task 'serve', ->
  hpserver = spawn('coffee',['main.coffee'])

gulp.task 'stop', ->
  hpserver.kill("SIGHUP")

gulp.task 'restart', ['stop','serve']

gulp.task 'default', ['styles','serve','watch']

