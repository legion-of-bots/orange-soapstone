fs   = require 'fs'
path = require 'path'

Twit = require 'twit'

# Resolve a file path for a configuration file
resolve_config_file = (file_name) ->
  path.resolve(__dirname, '..', 'config', file_name)

# Read a json config file.  Extension is assumed to be json
# If an error occurs then undefined is returned.
parse_config_file = (file_name) ->
  try
    JSON.parse(fs.readFileSync(resolve_config_file(file_name + '.json'), 'utf8'))
  catch error

# Returns a random integer between the arguments
random_between = (min, max) ->
  parseInt(Math.random() * (max - min) + min)

# Tweets a random one of the messages
tweet_random_message = () ->
  message = messages[random_between(0, messages.length)]
  if not message? then console.error "Message not found"
  console.log """
    Tweeting:
    #{message}
    """
  twit.post 'statuses/update', { status: message }, (->) unless test_mode

# Main
config    = parse_config_file 'config'
messages  = parse_config_file 'all_messages'

test_mode = process.argv[2] == 'test'

if (test_mode or config?) and messages?

  twit = new Twit config.twitter unless test_mode
  do tweet_random_message

else
  console.error """
    There was an error parsing one of the config files.
    Please make sure that config/config.json exists and has the necessary values.
    Also remember to run grunt to generate the list of possible tweets.
    """
