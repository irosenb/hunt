namespace :users do
  desc "Getting users locations from Twitter"
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

  task get: :environment do
    ActiveRecord::Base.transaction do
      SmarterCSV.process("./lib/users.csv", {:col_sep => ";", :quote_char => ";", :key_mapping => {:name => :name, :username => :username, :id => :hunt_id, :created_at => :hunted_at, :maker_of_count => :maker_count}, :remove_unmapped_keys => true}) do |chunk| 
        chunk.each do |i|
          maker = i[:maker_count] || 0
          if maker.to_i > 0 
            i.delete(:maker_count)
            User.create(chunk)
          end
        end
      end
    end
  end

  task retrieve: :environment do
    ActiveRecord::Base.transaction do
      users = User.where.not(latitude: nil)
      users.map(&:username).each do |name|
        response = Unirest.get "https://api.producthunt.com/v1/users/#{name}", headers: { "Authorization" => "Bearer #{ENV["ph_dev_token"]}" }
        binding.pry
        puts link = response.body["user"]["maker_of"].first["redirect_url"]
        user.product_link = link
        puts user.save  
      end
    end
  end
end
