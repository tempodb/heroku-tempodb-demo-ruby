require 'sinatra'
require 'tempodb'

get '/' do
  api_key = ENV['TEMPODB_API_KEY']
  api_secret = ENV['TEMPODB_API_SECRET']
  api_host = ENV['TEMPODB_API_HOST']
  api_port = Integer(ENV['TEMPODB_API_PORT'])
  api_secure = ENV['TEMPODB_API_SECURE'] == "False" ? false : true

  client = TempoDB::Client.new( api_key, api_secret, api_host, api_port, api_secure )
  out = ""
  client.get_series().each{ |series| out += series.to_json + "<br/>"  }
  out
end
