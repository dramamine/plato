module.exports = (grunt) ->
  
  #load tasks
  require('load-grunt-tasks') grunt
  require('load-grunt-config') grunt

  
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-forever'
  # grunt.loadNpmTasks 'grunt-includes'

  #config
  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    # express:
    #   options:
    #     cmd: 'coffee'
    #     script: '<%= pkg.main %>'
    #     delay: 1
    #   dev: {}


    # pkg: '<json:package.json>'
    # bower: '<json:bower.json>'

    targets:
      src: [
        'src/**/*.coffee'
        'public/**/*.coffee'
        'src/views/*.jade'
        'Gruntfile.coffee' # who watches the watchers?
      ]
      # unittest: [
      #   'test/unit/**/*.coffee'
      #   'test/helpers/**/*.coffee'
      # ]
      # integrationtest: ['test/integration/**/*.coffee']
      gruntfile: ['Gruntfile.coffee']

    coffeelint:
      all: '<%= targets %>'


    jade:
      options:
        pretty: true
      src: ['src/**/*.jade']

    express:
      options:
        opts: ['/usr/bin/coffee']
        script: '<%= pkg.main %>'
        delay: 1

      # prob don't need this
      watch:
        background: true

    watch:
      express:
        files: '<%= targets.src %>'
        tasks: 'express'
        options:
          spawn: false

    forever:
      server:
        options:
          command: 'coffee'
          index: '<%= pkg.main %>'

    
    # currently unused
    # shell:
    #   options:
    #     stdout: true
    #     stderr: true


    # copy:
    #   main:
    #     expand: true
    #     cwd: 'src/public/views/'
    #     src: '**/*.html'
    #     dest: 'public/views/'
    #     filter: 'isFile'
    #   modules:
    #     expand: true
    #     cwd: 'src/modules/'
    #     src: '**/*.html'
    #     dest: 'public/views/'
    #     filter: 'isFile'
  

  grunt.registerTask 'default', [
    # 'coffeelint'
    # 'jade'
    'express:watch'
    'watch'
    ]

  grunt.registerTask 'db-reset', [
    'shell:dbsetup',
    'shell:dbtest'
    ]

  grunt.registerTask 'forever-start', [
    'forever:server:start'
    ]
  grunt.registerTask 'forever-stop', [
    'forever:server:stop'
    ]
  grunt.registerTask 'forever-restart', [
    'forever:server:restart'
    ]