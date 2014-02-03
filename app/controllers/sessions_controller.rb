class SessionsController < ApplicationController
  
  before_filter :require_current_user, :only => [:destroy]
  before_filter :require_no_current_user, :only => [:new, :create]
  
  def new
    render :new
  end
  
  def create
    user = User.find_by_credentials(params[:email].downcase, params[:password])
    
    if user
      log_in(user) # in SessionsHelper
      flash[:alert] = ["Welcome #{user.name}!"]
      redirect_to root_url
    else
      flash[:error] = ["Wrong credentials"]
      p User.all
      redirect_to new_session_url
    end
  end
  
  def destroy
    log_out_current_user! # in SessionsHelper
    flash[:alert] = ["Come back soon!"]
    redirect_to new_session_url
  end
end
