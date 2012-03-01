require 'sinatra'
require 'tempodb'

get '/' do
  request_start = Time.now

  api_key = ENV['TEMPODB_API_KEY']
  api_secret = ENV['TEMPODB_API_SECRET']
  api_host = ENV['TEMPODB_API_HOST']
  api_port = Integer(ENV['TEMPODB_API_PORT'])
  api_secure = ENV['TEMPODB_API_SECURE'] == "False" ? false : true

  
  client = TempoDB::Client.new( api_key, api_secret, api_host, api_port, api_secure )
  out = ""

  read_start = Time.now
  series = client.get_series()
  read_end = Time.now

  series.each{ |series| out += series.to_json + "<br/>"  }

  request_end = Time.now

  client.write_bulk( Time.now, [ {'key'=>'heroku-page-load-speed', 'v'=>request_end-request_start}, {'key'=>'heroku-tempodb-read-speed', 'v'=>read_end-read_start} ] )
  out
end
