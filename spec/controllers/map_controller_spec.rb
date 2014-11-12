require 'rails_helper'

RSpec.describe MapController, :type => :controller do
  render_views
	subject do 
		get :index, format: :json
		user = JSON.parse(response.body).first
		user.to_json
	end

  context 'JSON' do
    it "should have a type" do
    	expect(subject).to have_json_type(String).at_path("type")  
    end

    it "should have properties" do
    	expect(subject).to have_json_size(4).at_path("properties")
    end
  end
end
