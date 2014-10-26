tw_client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "#{ENV['tw_api_key']}"
  config.consumer_secret     = "#{ENV['tw_api_secret']}"
  config.access_token        = "#{ENV['tw_dev_token']}"
  config.access_token_secret = "#{ENV['tw_dev_secret']} "
end