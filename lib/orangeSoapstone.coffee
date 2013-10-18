fs   = require 'fs'
path = require 'path'

Twit = require 'twit'

# Resolve a file path for a configuration file
resolve_config_file = (file_name) ->
  path.resolve(__dirname, '..', 'config', file_name)

# Read a json config file.  No extension required
parse_config_file = (file_name) ->
  JSON.parse(fs.readFileSync(resolve_config_file(file_name + '.json'), 'utf8'))

# Wrapper to switch the arguments for setTimeout
set_timeout = (interval, callback) ->
  setTimeout(callback, interval).ref()

# Returns a random number between the arguments
random_between = (min, max) ->
  Math.random() * (max - min) + min

# Returns a random number between the interval min and max settings
interval = () ->
  random_between config.settings['interval-min'], config.settings['interval-max']

# Tweets a random one of the messages
tweet_random_message = () ->
  message = messages[Math.floor(Math.random() * messages.length)]
  console.log ''
  console.log 'Tweeting:'
  console.log message
  twit.post 'statuses/update', { status: message }, (->)

# Tweets a random message and then schedules the next tweet
tweet_loop = () ->
  tweet_random_message()
  set_timeout interval(), tweet_loop

config   = parse_config_file 'config'
messages = parse_config_file 'all_messages'

twit     = new Twit config.twitter

set_timeout interval(), tweet_loop
