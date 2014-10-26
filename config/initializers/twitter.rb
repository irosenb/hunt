tw_client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "#{tw_api_key}"
  config.consumer_secret     = "#{tw_api_secret}"
  config.access_token        = "#{tw_dev_token}"
  config.access_token_secret = "#{tw_dev_secret} "
end