class MapController < ApplicationController
  def show
    @users = User.all
    @json = []

    @users.each do |user|
      if !user.latitude.nil?
        @json << {
        type: "Feature",
           geometry: {
             type: "Point",
             coordinates: [user.longitude, user.latitude]
           },
           properties: {
            title: user.name,
            description: user.username
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
