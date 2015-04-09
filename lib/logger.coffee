fs   = require 'fs'
path = require 'path'

class Logger

  constructor: (@path) ->

  log_tweet: (tweet) ->
    file_path = path.join @path, 'tweets.json'
    fs.readFile file_path, (err, data) ->
      data = JSON.parse data
      data[tweet] = if data[tweet]? then data[tweet] + 1 else 1
      fs.writeFile file_path, JSON.stringify(data, undefined, 2)

module.exports = new Logger path.join(__dirname, '..', 'log')
