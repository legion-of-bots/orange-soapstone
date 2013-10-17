Twit = require 'twit'

module.exports = (config, messages) ->
  message = messages[Math.floor(Math.random() * messages.length)]

  twit = new Twit config

  twit.post('statuses/update', status message)
