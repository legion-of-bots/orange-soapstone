fs = require 'fs'

replace_regex = /\*\*\*\*/

capitalize_string = (string) ->
  string.charAt(0).toUpperCase() + string.slice(1)

to_json = (obj) ->
  JSON.stringify(obj, undefined, 2)

class Template
  constructor: (@template, @options) ->

  has_replace: () ->
    replace_regex.test @template

  capitalize: () ->
    @options.capitalize? && @options.capitalize

  to_string: (message) ->
    if this.has_replace()
      if this.capitalize()
        message = capitalize_string(message)
      @template.replace(replace_regex, message)
    else
      @template

module.exports = () ->

  messages = this.data.messages

  # create template objects
  templates = []
  for template, options of this.data.templates
    templates.push(new Template(template, options))

  all_messages = []
  for template in templates
    if template.has_replace()
      for _, msgs of messages
        for message in msgs
          all_messages.push(template.to_string(message))
    else
      all_messages.push(template.to_string())

  fs.writeFileSync(this.data.out, to_json(all_messages))
