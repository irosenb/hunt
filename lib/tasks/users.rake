namespace :users do

  task get: :environment do
  	response = Unirest.get "https://api.producthunt.com/v1/posts", headers: { "Authorization" => "Bearer #{ENV["ph_dev_token"]}" }
    # puts response.body
    binding.pry
    maker_posts = response.body["posts"].select { |key, hash| hash["maker_inside"] == true }
    maker_posts.each do |post|
      
    end

    response.body["posts"].first

  end

end
