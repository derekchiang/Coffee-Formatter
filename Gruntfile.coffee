module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')


    coffee:
      lib:
        expand: true
        cwd: 'src/'
        src: ['*.litcoffee', '*.coffee']
        dest: 'lib/'
        ext: '.js'
      test:
        expand: true
        cwd: 'test/'
        src: ['*.coffee']
        dest: 'test/'
        ext: '.js'


    coffeelint:
      options:
        no_empty_param_list:
          level: 'error'
        max_line_length:
          level: 'ignore'

      src: [ 'src/*.litcoffee', 'src/*.coffee', 'test/*.coffee', '*.coffee']
      gruntfile: ['Gruntfile.coffee']


    docco:
      docs:
        src: ['src/*.litcoffee', 'src/*.coffee'],
        options:
          output: 'docs/'
          layout: 'linear'


    simplemocha:
      all:
        src: ['test/*.js']

    clean: ['lib/', 'docs', 'test/*.js']


  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-docco')
  grunt.loadNpmTasks('grunt-simple-mocha')


  grunt.registerTask('default', ['coffee', 'coffeelint', 'docco'])
  grunt.registerTask('test', ['coffee', 'coffeelint', 'simplemocha'])
  grunt.registerTask('prepublish', ['clean', 'coffee', 'coffeelint', 'docco'])
