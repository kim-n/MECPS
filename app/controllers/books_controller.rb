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

    params[:book][:cover] = params[:cover][:file] || params[:cover][:link].strip || ""  

    params[:book][:source] = params[:source][:file] || params[:source][:link].strip || ""  
    book = Book.new(params[:book])
    
    if book.save
      flash[:alert] = ["#{book.title} added!"]
      redirect_to book_url(book)
    else
      flash[:error] = flash[:error].nil? ? book.errors.full_messages : flash[:error] + book.errors.full_messages
      redirect_to new_book_url
    end
  end
  
  def edit
    @book = Book.find_by_id(params[:id])
    render :edit
  end
  
  def update
    params[:book][:cover] = params[:cover][:file] || params[:cover][:link].strip || ""  if params[:cover]

    params[:book][:source] = params[:source][:file] || params[:source][:link].strip || ""  if params[:source]
    
    @book = Book.find_by_id(params[:id])
    if @book.update_attributes(params[:book])
      flash[:alert] = ["Changes saved"]
      redirect_to book_url(@book)
    else
      flash[:error] = @book.errors.full_messages
      redirect_to edit_book_url(@book)
    end
    
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    
    redirect_to root_url
  end
end
