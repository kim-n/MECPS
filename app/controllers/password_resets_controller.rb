class PasswordResetsController < ApplicationController

  before_filter :require_no_current_user, :only => [:new, :create, :edit, :update]

  def new
    render :new
  end

  def create
    user = User.find_by_email(params[:email].downcase)
    
    if user
      if user.activated
        user.reset_activation_token!
        UserMailer.reset_password(user).deliver
        flash[:alert] = ["Email sent with password reset instructions."]
        redirect_to root_url
      else
        UserMailer.new_user(user).deliver
        flash[:error] = ["Activate your account, a new activation email has been sent"]
        redirect_to root_url
      end
    else
      flash[:error] = ["Email does not exits in database"]
      redirect_to new_password_reset_url
    end
  end
  
  def edit
    user = User.find_by_activation_token(params[:reset_token])
    
    if user 
      render :edit
    else
      flash[:error] = ["Invalid reset token. Request new password reset."]
      redirect_to new_password_reset_url
    end
  end
  
  def update
    user = User.find_by_activation_token(params[:reset_token])
    if params[:user][:password] == params[:password_reenter]
      if user.update_attributes(params[:user])
        flash[:alert] = ["Passwords successfully changed"]
        redirect_to new_session_url
      else
        flash[:error] = user.errors.full_messages
        redirect_to edit_password_reset_url(reset_token: params[:reset_token])
      end
    else
      flash[:error] = ["Passwords must match"]
      redirect_to edit_password_reset_url(reset_token: params[:reset_token])
    end
  end
end
