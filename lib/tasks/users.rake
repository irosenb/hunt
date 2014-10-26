namespace :users do

  task get: :environment do
  	
  	response = Unirest.get "https://api.producthunt.com/v1/posts",
  		headers: {
  			"Authorization" => "Bearer #{ENV["ph_dev_token"]}",
  		}

  end

  task locations: :environment do
  	users = User.all
    users.map(&:username).each_slice(100).to_a.each do |group|
      puts twis = group.join(",")
      tw_users = TW_CLIENT.users(twis)
      tw_users.each do |tw_user|
        puts tw_user.screen_name
        user = User.where("lower(username) = ?", tw_user.screen_name.downcase).first
        location = Geokit::Geocoders::MultiGeocoder.geocode(tw_user.location)
        user.latitude = location.latitude
        user.longitude = location.longitude
        puts user.save!
      end
    end
	end
end
