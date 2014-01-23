require 'spec_helper'

describe BooksController do
  describe "GET index" do
    it "assigns @@books" do
      book = FactoryGirl.create(:book)
      get :index
      expect(assigns(:books)).to eq([book])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
  
  describe "GET show" do
    it "assigns @book" do
      book = FactoryGirl.create(:book)
      get :show, id: book.id
      expect(assigns(:book)).to eq(book)
    end
    
    it "redirects to Books index if book does not exist" do
      get :show, id: 1
      expect(response).to redirect_to :books
    end

    it "renders the show template" do
      book = FactoryGirl.create(:book)
      get :show, id: book.id
      expect(response).to render_template("show")
    end
  end
  
  describe "GET new" do
    
    it "redirects to root index if user is not an admin" do
      get :new
      expect(response).to redirect_to :root
    end

    it "renders the new template" do
      @user = FactoryGirl.create(:user) 
      controller.stub(:current_user).and_return(@user)
      get :new
      expect(response).to_not redirect_to :root    
      expect(response).to render_template("new")
    end
    
    it "renders the new template" do
      @user = FactoryGirl.create(:user) 
      controller.stub(:current_user).and_return(@user)
      get :new
      expect(response).to_not redirect_to :root    
      expect(response).to render_template("new")
    end
  end
  
  describe "POST create" do
    
  end
  
  describe "PUT update" do
    
  end
  
  describe "DELETE destroy" do
    
  end
end
