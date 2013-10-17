messsagesTask = require './grunt/tasks/messages'

module.exports = (grunt) ->
  grunt.initConfig
    messages: require './grunt/config/messages'

  grunt.registerMultiTask 'messages', messsagesTask

  grunt.registerTask 'run', () ->
    fs   = require 'fs'
    path = require 'path'

    config   = path.resolve __dirname, 'config', 'config.json'
    messages = path.resolve __dirname, 'config', 'all_messages.json'

    require('./lib/orangeSoapstone')(config, messages)

  grunt.registerTask 'default', ['messages', 'run']
