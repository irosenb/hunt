namespace :users do

  task get: :environment do
  	
  	response = Unirest.get "https://api.producthunt.com/v1/posts",
  		headers: {
  			"Authorization" => "Bearer #{ENV["ph_dev_token"]}",
  		}

  end

  task locations: :environment do

  	users = User.all
  	tw_usernames = Array.new()
  	
  	users.each_with_index do |user, i|
  		tw_usernames.push(user.username)

  		if (i+1 % 100) != 0 || i+1 != users.length
  			tw_usernames_q = tw_usernames.join(",")
			tw_users = TW_CLIENT.users(tw_usernames_q)

			tw_users.each do |tw_user|
				user.location = tw_user.location
				user.save
			end

  			tw_usernames.clear
  		end
	end

  end

end
