namespace :users do

  task get: :environment do
  	
  	response = Unirest.get "https://api.producthunt.com/v1/posts",
  		headers:{
  			"Authorization" => "Bearer #{ENV["ph_dev_token"]}",
  		}

  	puts response.body

  end

end
