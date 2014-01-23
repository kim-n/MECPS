class QuestionsController < ApplicationController
  
  def new
    @book = Book.find_by_id(params[:book_id])
    render :new
  end
  
  def create
    params[:question][:book_id] = params[:book_id]
    @question = current_user.questions.new(params[:question])
    
    if @question.save
      flash[:alert] = ["Question created!"]
      redirect_to book_url(@question.book)
    else
      flash[:error] = @question.errors.full_messages
      redirect_to book_url(@question.book)
    end
  end
  
  def show
    @question = Question.find_by_id(params[:id])
    render :show
  end
  
  def edit 
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
end
