child = require('child_process').spawn

module.exports = exports = (grunt)->
  @options =
    hpserver:null

  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.initConfig
    watch:
      hapi:
        files:['!./app/assets/**/*','./app/**/*.coffee']
        tasks: 'restart-hapi'
        options:
          spawn:false

  
  grunt.registerTask 'restart-hapi','restart backend server', ->
    hpserver = grunt.option('hpserver')
    hpserver.kill('SIGHUP')
    grunt.task.run('hapi')

  grunt.registerTask 'hapi','run backend server', ->
    hpserver = child('coffee',['main.coffee'],stdio:'inherit')
    grunt.option('hpserver',hpserver)

  grunt.registerTask('default',['hapi','watch'])
