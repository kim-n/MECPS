class UsersController < ApplicationController
  
  before_filter :require_current_user, :only => [:edit, :update]
  before_filter :require_admin, :only => [:new, :create]
  
  def index
    @users = User.all
    render :index
  end
  
  def show
    @user = User.find_by_id(params[:id])
    @user ? ( render :show ) : ( redirect_to users_url )
  end
  
  def new
    render :new
  end
  
  def create
    params[:user][:email] = params[:user][:email].downcase
    params[:user][:name] =  params[:user][:name].split.map(&:capitalize).join(" ")
    params[:user][:password] = params[:user][:email]
     
    user = User.new(params[:user])
    
    if user.save
      UserMailer.new_user(user).deliver
      flash[:alert] = ["User activation sent out!"]
      redirect_to admin_url
    else
      flash[:error] = user.errors.full_messages
      redirect_to new_user_url
    end
  end
  
  def edit
    @user = User.find_by_id(params[:id])
    if is_admin?(current_user) || @user == current_user
      render :edit
    else
      flash[:alert] = ["You can't edit another user's profile"]
      redirect_to root_url
    end
  end
  
  def update
    user = User.find(params[:id])

    params[:user][:avatar] = params[:avatar][:file] || params[:avatar][:link].strip || "" if params[:avatar]
    
    params[:user].each do |key, value| 
      params[:user].delete(key) if value.blank?
    end
    
    user.not_updating_password = true unless params[:user][:password]

    if params[:user].empty?
      flash[:alert] = ["No changes made"]
      redirect_to user_url(user)
    else

      if user.update_attributes(params[:user]) 
        flash[:alert] = ["Changes saved"]
        redirect_to user_url(user)
      else
        flash[:error] = user.errors.full_messages
        redirect_to edit_user_url(user)
      end 
    end   
  end
  
  def destroy
  end
  
end
