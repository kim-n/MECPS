class LinksController < ApplicationController
  
  def show
    @link = Link.all.first
    render :show
  end
  
  def edit
    @link = Link.all.first
    render :edit
  end
  
  def update
    @link = Link.all.first
    
    @link.page_html = params[:page_html]
    
    if @link.save
      flash[:alert] = ["Links saved!"]
      redirect_to links_url
    else
      flash[:error] = @link.errors.full_messages
      redirect_to links_url
    end
  end
end
