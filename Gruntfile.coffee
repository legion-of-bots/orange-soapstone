messsagesTask = require './grunt/tasks/messages'

module.exports = (grunt) ->
  grunt.initConfig
    messages: require './grunt/config/messages'

  grunt.registerMultiTask 'messages', messsagesTask

