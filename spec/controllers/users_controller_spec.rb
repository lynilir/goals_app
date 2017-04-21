require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  subject(:user) {User.create!(username: "User4", password: "abcdef")}

  describe "GET #new" do
    it "renders the new links page" do
      get :new, user: {}

      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    it "with invalid params" do

      post :create, user: {username: 'werwajkl', password: 'abc' }
      expect(response).to render_template("new")
      expect(flash[:errors]).to be_present
    end

    it "with valid params" do
      post :create, user: {username: 'werwajkl', password: 'abcdefg' }
      expect(response).to redirect_to(user_url(User.last))
    end
  end

  describe "GET #show" do
    it "shows user's page" do
      get :show

      expect(response).to render_template("show")
    end
  end

end
