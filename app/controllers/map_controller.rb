class MapController < ApplicationController
  def show
    @users = User.all
    @json = []

    # [CJL] Work to keep your Controllers skinny and not fat.
    #
    # The following block of code is good, but I don't think it belongs here.
    # This looks like a great candidate for a class method in the Users model.
    #   => You are running this for all users that exist anyway.
    #   => Controller shoudn't care how the object it displays is built.
    #
    # Besides, this looks much nicer --- will leave the name up to you:
    #   => @json = User.get_map_json
    #
    # This means your entire controller can be 5 lines of code. :)

    @users.each do |user|
      # [CJL] In the past, I was a big fan of using ! in front of if statements.
      # However, Rails ActiveSupport let's you be really expressive, like so:
      #   => if user.latitude.present?
      #
      # Check this out for how present? is implemented:
      #   => http://api.rubyonrails.org/classes/Object.html#method-i-present-3F

      if !user.latitude.nil?
        @json << {
        type: "Feature",
           geometry: {
             type: "Point",
             coordinates: [user.longitude, user.latitude]
           },
           properties: {
            name: user.name,
            username: user.username,
            # product: user.products.first,
            title: "<a target='_blank' href='http://twitter.com/#{user.username}'>#{user.name}</a>"
          }
        }
      end
    end

    respond_to do |format|
      format.html 
      format.json { render json: @json } 
    end
  end
end
