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
     
    # params[:user][:avatar] = params[:avatar][:file] || params[:avatar][:link] || ""
    user = User.new(params[:user])
    
    if user.save
      UserMailer.new_user(user).deliver
      flash[:alert] = ["User created!"]
      redirect_to user_url(user)
    else
      flash[:error] = user.errors.full_messages
      render :new
    end
  end
  
  def edit
    @user = User.find_by_id(params[:id])
    if is_admin?(current_user) || user == current_user
      render :edit
    else
      flash[:alert] = ["You can't edit another user's profile"]
      redirect_to root_url
    end
  end
  
  def update
    user = User.new(params[:user])
    
  end
  
  def destroy
  end
  
  def complete_signup
    render :complete_signup
  end
  
  def create_password
    if params[:user][:password] == params[:password_reenter]
      user = User.confirm_activation_token(params[:activation_token], params[:email])
      if user && user.update_attributes(params[:user])
        log_in(user)
        redirect_to root_url
      else
        flash[:error] = (user.errors.full_messages if user) || ["Email isn't match"]
        redirect_to complete_signup_url(activation_token: params[:activation_token])
      end
      
    else
      flash[:error] = ["Passwords must match"]
      redirect_to complete_signup_url(activation_token: params[:activation_token])
    end
  end
  
end
