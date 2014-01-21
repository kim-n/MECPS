class UsersController < ApplicationController
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
  
  def edit
    render :edit
  end
  
  def create
    user = User.new(params[:user])
    if user.save
      redirect_to user_url(user)
    else
      render :new
    end
  end
  
  def update
    
  end
  
  def destroy
    
  end
end