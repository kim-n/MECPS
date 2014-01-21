require 'spec_helper'

describe UsersController do
    # 
  # integrate_views
  # fixtures :menu_items
  # 
  # it "should redirect to index with a notice on successful save" do
  #   MenuItem.any_instance.stubs(:valid?).returns(true)
  #   post 'create'
  #   assigns[:menu_item].should_not be_new_record
  #   flash[:notice].should_not be_nil
  #   response.should redirect_to(menu_items_path)
  # end
  # 
  # it "should re-render new template on failed save" do
  #   MenuItem.any_instance.stubs(:valid?).returns(false)
  #   post 'create'
  #   assigns[:menu_item].should be_new_record
  #   flash[:notice].should be_nil
  #   response.should render_template('new')
  # end
  # 
  # it "should pass params to menu item" do
  #   post 'create', :menu_item => { :name => 'Plain' }
  #   assigns[:menu_item].name.should == 'Plain'
  # end
  # 
  # 
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
end
