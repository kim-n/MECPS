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
    user = User.new(params[:user])
    
    if user.save
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
end
