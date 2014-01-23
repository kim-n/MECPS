class CommentsController < ApplicationController
  
  before_filter :require_current_user
  
  def create
    params[:comment][:question_id] = params[:question_id]
    @comment = current_user.comments.new(params[:comment])
    
    if @comment.save
      flash[:alert] = ["Comment Saved!"]
      redirect_to question_url(params[:question_id])
    else
      flash[:error] = ["ERROR: Comment not saved!"]
      flash[:error] += @comment.errors.full_messages
      redirect_to question_url(params[:question_id])
    end
  end
  
  def edit
    
  end
  
  def update
    
  end

end
