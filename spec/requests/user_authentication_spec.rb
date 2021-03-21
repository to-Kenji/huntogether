require 'rails_helper'

RSpec.describe "UserAuthentications", type: :request do
  before do
    @user = User.create(
      name: "kenji",
      email: "kenji@example.com",
      password: "password",
      password_confirmation: "password"
    )
  end
  
  shared_context "when signed in" do
    before do
      sign_in @user
    end
  end

  describe "GET edit" do
    subject { get edit_user_registration_path }

    context "when authenticated" do
      include_context "when signed in"
      it "should success" do
        is_expected.to eq 200
      end
    end

    context "when unAuthenticated" do
      it "should redirect" do
        is_expected.to redirect_to new_user_session_path
      end
    end
  end
  
  describe "GET show" do
    subject { get user_path(@user) }

    context "when authenticated" do
      include_context "when signed in"
      it "should success" do
        is_expected.to eq 200
      end
    end

    context "when unAuthenticated" do
      it "should redirect" do
        is_expected.to redirect_to new_user_session_path
      end
    end
  end
end