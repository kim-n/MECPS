class AdminsController < ApplicationController
  
  before_filter :require_admin

  def home
    render :index
  end

  # def users
  #   @users = User.valid_users
  #   render :users
  # end
  # 
  # def clubs
  #   @clubs = Club.all
  #   render :clubs
  # end
  # 
  # def activation
  #   @requests = User.requests
  #   @pending = User.pending
  # end
  # 
end
