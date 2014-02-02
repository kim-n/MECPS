class ActivatesController < ApplicationController
  before_filter :require_no_current_user, :only => [:new, :create]
  
  def new
    user = User.find_by_activation_token(params[:activation_token])
    
    if user
      if user.activated
        flash[:error] = ["#{user.email} already activated!"]
        redirect_to root_url
      else
        render :new
      end
    else
      flash[:error] = ["Invalid activation token"]
      redirect_to root_url
    end
  end
  
  def create
    params[:user][:avatar] = params[:avatar][:file] || params[:avatar][:link].chomp || ""
    
    user = User.find_by_activation_token(params[:activation_token])
    
    if user.email == params[:email]
      if params[:user][:password] == params[:password_reenter]
        if user.update_attributes(params[:user])
          user.update_column(:activated, true)
          log_in(user)
          redirect_to root_url
        else
          flash[:error] = user.errors.full_messages
          redirect_to new_activate_url(activation_token: params[:activation_token])      
        end
      else
        flash[:error] = ["Passwords must match"]
        redirect_to new_activate_url(activation_token: params[:activation_token])      
      end
    else
      flash[:error] = ["Email isn't match"]
      redirect_to new_activate_url(activation_token: params[:activation_token])
    end
  end
  
end
