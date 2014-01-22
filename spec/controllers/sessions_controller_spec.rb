require 'spec_helper'

describe SessionsController do
  let :user do
    FactoryGirl.create(:user) 
  end
  let :credentials do
    { email: "user@email.com", password: "password"}
  end
  
  context "when no current user" do
    it "logs in a user" do
      user
      get :create, credentials
      expect(response).to redirect_to user_url(user)
    end
    
    it "redirects if user tries to log out" do
      delete :destroy
      expect(response).to redirect_to :new_session 
    end
  end
  context "when current user" do
    it "logs out current user" do
      user
      get :create, credentials
      delete :destroy
      expect(response).to redirect_to new_session_url
    end
    
    it "redirects if user tries to log in again" do
      user
      get :create, credentials
      get :create, credentials
      expect(response).to redirect_to user_url(user)
    end
  end
end
