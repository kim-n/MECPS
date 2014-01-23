require 'spec_helper'

describe UsersController do
  integrate_views
 
  describe "GET index" do
    it "assigns @users" do
      user = FactoryGirl.create(:user)
      get :index
      expect(assigns(:users)).to eq([user])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
  
  describe "GET show" do
    it "assigns @user" do
      user = FactoryGirl.create(:user)
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
    
    it "redirects to Users index if user does not exist" do
      user = FactoryGirl.create(:user)
      get :show, id: 2
      expect(response).to redirect_to :users
    end

    it "renders the show template" do
      user = FactoryGirl.create(:user)
      get :show, id: user.id
      expect(response).to render_template("show")
    end
  end
  
  describe "GET new" do
    it "renders the new template" do
      get :new
      expect(response).to_not redirect_to :root    
      expect(response).to render_template("new")
    end
  end
  
  describe "POST create" do
    
  end
  
  describe "GET new" do
    
  end
end
