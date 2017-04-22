require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url

    expect(page).to have_content "New User"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'username', :with => "User1"
      fill_in 'password', :with => "password"
      click_on 'Sign Up'
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content "User1"
    end

  end

end

feature "logging in" do


  feature "sign in a user" do
    let(:user) { User.create(username: "user1", password: "password") }
    before(:each) do
      user
      visit new_sessions_url
      fill_in 'username', :with => "user1"
      fill_in 'password', :with => "password"
      click_on 'Sign In'
    end

    scenario "shows username on the homepage after login" do
      visit new_sessions_url
      expect(page).to have_content "user1"
    end

  end



end

feature "logging out" do

  scenario "begins with a logged out state" do
    expect(session[:session_token]).to be_nil
  end

  scenario "doesn't show username on the homepage after logout" do
    expect(page).not_to have_content "User1"
  end

end
