spawn = require('child_process').spawn
q = require 'q'
gulp = require 'gulp'
sass = require 'gulp-sass'

refresh = require 'gulp-livereload'
lrserver = require 'tiny-lr'

gutil = require 'gulp-util'

hpserver = null
tinylr = lrserver()

gulp.task 'styles', ->
  gulp.src('./app/assets/css/*.scss')
    .pipe(sass())
    .pipe(gulp.dest('./public/css'))

gulp.task 'watch', ->
  gulp.watch('app/assets/css/*.scss',['styles','refresh-lr'])
  gulp.watch('app/**/*.coffee',['restart','refresh-lr'])
  

gulp.task 'start-lr', ->
  tinylr.listen(35729, ->
    gutil.log "tinylr is ready on 35729"
  )
  tinylr.on('message', (m)->
    gutil.log m
  )

gulp.task 'refresh-lr', ->
  refresh(tinylr)
  gutil.log "refresh LR Server"

gulp.task 'serve', ->
  hpserver = spawn('coffee',['main.coffee'],stdio:'inherit')

gulp.task 'stop', ->
  hpserver.kill("SIGHUP")

gulp.task 'restart', ['stop','serve']

gulp.task 'default', ['styles','start-lr','serve','watch']

