fs   = require 'fs'
path = require 'path'

resolve_config_file = (file_name) ->
  path.resolve(__dirname, '..', '..', 'config', file_name)

parse_json_file = (file_path) ->
  JSON.parse(fs.readFileSync(file_path, 'utf8'))

module.exports =
  messages:
    templates: parse_json_file(resolve_config_file('templates.json'))
    messages:  parse_json_file(resolve_config_file('messages.json'))
    out:       resolve_config_file('all_messages.json')
