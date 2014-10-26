namespace :users do

  task get: :environment do
    ActiveRecord::Base.transaction do
      SmarterCSV.process("/Users/isaac/Downloads/ph-export--2014-10-25_12-25-21/users--2014-10-25_12-25-21-UTC.csv", {:col_sep => ";", :quote_char => ";", :key_mapping => {:name => :name, :username => :username, :id => :hunt_id, :created_at => :hunted_at, :maker_of_count => :maker_count}, :remove_unmapped_keys => true}) do |chunk| 
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
  
end
