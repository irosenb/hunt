class User < ActiveRecord::Base
  has_many :products
  scope :no_location, -> { where(latitude: nil) }
  scope :lowercased, ->(screen_name) { where("lower(username) = ?", screen_name.downcase).first }
  # scope :

  def locations
    users = User.no_location
    users.map(&:username).each_slice(100).to_a.each do |group|
      puts user_query = group.join(",")
      twitter_users = TW_CLIENT.users(user_query)
      twitter_users.each do |twitter_user|
        puts twitter_user.screen_name
        user = User.lowercased
        location = Geokit::Geocoders::MultiGeocoder.geocode(twitter_user.location)
        user.location = twitter_user.location
        user.latitude = location.latitude
        user.longitude = location.longitude
        puts user.save!
      end
    end
  end

  def update
    ActiveRecord::Base.transaction do
      
    end
  end

  def get
    ActiveRecord::Base.transaction do
      get_users { |chunk, i| puts i[:name] }
      # User.create(chunk)
    end
  end

  def get_products
    users = User.includes(:products).where.not(latitude: nil).where(products: {id: nil})
    users.each do |user|
      response = Unirest.get "https://api.producthunt.com/v1/users/#{user.username}", headers: { "Authorization" => "Bearer #{ENV["ph_dev_token"]}" }
      response.body["user"]["maker_of"].each do |p| 
        puts p["redirect_url"]
        puts user.products.build(link: p["redirect_url"], name: p["name"])
      end
      puts user.save  
    end
  end


  def get_users
    SmarterCSV.process("./lib/users.csv", {:col_sep => ";", :quote_char => ";", :key_mapping => {:name => :name, :username => :username, :id => :hunt_id, :created_at => :hunted_at, :maker_of_count => :maker_count, :image => :image}, :remove_unmapped_keys => true}) do |chunk| 
      chunk.each do |i|
        maker = i[:maker_count] || 0
        if maker.to_i > 0
          i.delete(:maker_count)
          yield(chunk, i) if block_given? 
        end
      end    
    end
  end

end
