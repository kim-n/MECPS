class BooksController < ApplicationController

  before_filter :require_admin, :only => [:new, :create, :edit, :update]

  def index
    @books = Book.all
    render :index
  end
  
  def show
    @book = Book.find_by_id(params[:id])
    @book ? ( render :show ) : ( redirect_to books_url )
  end
  
  def new
    render :new
  end
  
  def create
    params[:book][:image] = "http://www.authormedia.com/wp-content/uploads/2013/11/goodreads.jpeg" if params[:book][:image].blank?
    book = Book.new(params[:book])
    if book.save
      flash[:alert] = ["#{book.title} added!"]
      redirect_to book_url(book)
    else
      flash[:error] = book.errors.full_messages
      redirect_to new_book_url
    end
  end
  
  def edit
    @book = Book.find_by_id(params[:id])
    render :edit
  end
  
  def update
    @book = Book.find_by_id(params[:id])
    @book.update_attributes(params[:book])
    
    redirect_to book_url(@book)
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    
    redirect_to root_url
  end
end
