fs   = require 'fs'
path = require 'path'

messsagesTask = require './grunt/tasks/messages'

parse_json_file = (file_path) ->
  JSON.parse(fs.readFileSync(file_path, 'utf8'))

module.exports = (grunt) ->
  grunt.initConfig
    messages: require './grunt/config/messages'

  grunt.registerMultiTask 'messages', messsagesTask

  grunt.registerTask 'run', () ->
    done = this.async()
    config   = parse_json_file(path.resolve __dirname, 'config', 'config.json')
    messages = parse_json_file(path.resolve __dirname, 'config', 'all_messages.json')

    require('./lib/orangeSoapstone')(config, messages, done)

  grunt.registerTask 'default', ['messages', 'run']
