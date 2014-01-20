require 'spec_helper'

describe User do
  it "creates valid user" do
    FactoryGirl.create(:user).should be_valid
  end
  
  let(:incomplete_user) {user = FactoryGirl.build(:incomplete_user)}
    
  describe "email" do
    it "is required" do 
      FactoryGirl.build(:user, email: nil).should_not be_valid
      expect(incomplete_user).to have(1).error_on(:password)
    end
    it "is unique" do
      FactoryGirl.create(:user)
      FactoryGirl.build(:user).should_not be_valid
    end
    it "is a valid email" do
      FactoryGirl.build(:user, email: 'email').should_not be_valid
    end
  end
  
  describe "password" do
    it "is required" do
      FactoryGirl.build(:user, password: nil).should_not be_valid
      expect(incomplete_user).to have(1).error_on(:password)
    end
    it "is longer than 5 characters" do
      FactoryGirl.build(:user, password: "12345").should_not be_valid
    end
    it "is less than 20 characters" do
      FactoryGirl.build(:user, password: "012345678909876543210").should_not be_valid
    end
  end
  
  describe "name" do
    it "is required" do
      FactoryGirl.build(:user, name: nil).should_not be_valid
      expect(incomplete_user).to have(1).error_on(:name)
    end
  end
  
  describe "session_token" do
    it "is required" do
      FactoryGirl.build(:user, session_token: nil).should_not be_valid
      expect(incomplete_user).to have(1).error_on(:session_token)
    end
  end

end
