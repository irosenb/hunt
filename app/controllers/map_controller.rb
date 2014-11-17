class MapController < ApplicationController
  caches_action :index 

  def index
    @users = User.includes(:products).where.not(latitude: nil)
    
    respond_to do |format|
      format.html 
      format.js
      format.json
    end
  end

  def popup
    @users = User.includes(:products).where(username: params[:usernames])
    respond_to do |format|
      format.html { render partial: "popup" }
    end
  end
end
