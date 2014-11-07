class MapController < ApplicationController
  def index
    @users = User.includes(:products).where.not(latitude: nil)
    # @products = Product.all
    @json = []

    @users.each do |user|
      html = "<a href='#{user.products.first.link}'>#{user.products.first.name}</a> by <a href='http://twitter.com/#{user.username}'>#{user.name}</a>"
      @json << {
      type: "Feature",
         geometry: {
           type: "Point",
           coordinates: [user.longitude, user.latitude]
         },
         properties: {
          name: user.name,
          username: user.username,
          product: user.products.first.to_json,
          title: html
        }
      }
    end

    respond_to do |format|
      format.html 
      format.js
      format.json { render json: @json } 
    end
  end

  def popup
    @users = User.includes(:products).where(username: params[:usernames])
    respond_to do |format|
      format.html { render partial: "popup" }
    end
  end
end
