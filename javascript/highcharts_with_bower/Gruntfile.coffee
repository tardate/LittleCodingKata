module.exports = (grunt)->

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    bower_concat: {
      all: {
        dest: 'app/compiled.js',
        bowerOptions: {
          relative: false
        }
      }
    }
  })

  grunt.loadNpmTasks('grunt-bower-concat')

  grunt.registerTask('default', ['bower_concat'])
