namespace :users do
  # desc "Getting users locations from Twitter"
  
  task locations: :environment do
  	User.locations
	end

  task update: :environment do
  end

  task get: :environment do
    User.get
  end

  task get_products: :environment do
    # User.connection
    User.get_products
  end
end
