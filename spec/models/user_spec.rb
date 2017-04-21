require 'rails_helper'

RSpec.describe User, type: :model do

  describe User do
    let(:user) {User.create!(username: "User4", password: "abcdef")}

    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }

    it "create password_digest when password is given" do
      expect(user.password_digest).to_not be_nil
    end

    describe "finds a username by credentials" do
      before { user.save! }
      it "finds user by username and password" do
        expect(User.find_by_credentials("User4", "abcdef")).to eq(user)
      end
    end

    it "confirms password is correct" do
      expect(user.is_password?("abcdef")).to be true
    end

    it "changes user session token" do
      old_session_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).to_not eq(old_session_token)
    end

  end

end
