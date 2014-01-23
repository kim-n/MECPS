require 'spec_helper'

describe BooksController do
  
  let(:admin) { FactoryGirl.create(:admin) }
  
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
      controller.stub(:current_user).and_return(admin)
      get :new
      expect(response).to_not redirect_to :root    
      expect(response).to render_template("new")
    end
  end
  
  describe "POST create" do
    context "when user is not logged in" do
      it "redirects to root index" do
        get :new
        expect(response).to redirect_to :root
      end
    end

    context "when user is not admin" do
      it "redirects to root index" do
        controller.stub(:current_user).and_return( FactoryGirl.create(:user) )
        get :new
        expect(response).to redirect_to :root
      end
    end
      
    context "when user is admin" do
      before(:each){
        controller.stub(:current_user).and_return(admin)
      }
    
      it "creates a valid book object" do
        post :create, book: FactoryGirl.attributes_for(:book)
        expect(response).to redirect_to book_url(Book.last)
      end
    
      it "does not create an invalid book object" do
        post :create, book: FactoryGirl.attributes_for(:incomplete_book)
        expect(response).to redirect_to :new_book
      end
    end
    
  end
  
  describe "PUT update" do
    
  end
  
  describe "DELETE destroy" do
    
  end
end
