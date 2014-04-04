class AboutsController < ApplicationController
  
  def show
    @link = About.all.first
    render :show
  end
  
  def edit
    @link = About.all.first
    render :edit
  end
  
  def update
    @link = About.all.first
    
    @link.page_html = params[:page_html]
    
    if @link.save
      flash[:alert] = ["About Us saved!"]
      redirect_to about_url
    else
      flash[:error] = @link.errors.full_messages
      redirect_to about_url
    end
  end
  
end
