class MiscPagesController < ApplicationController
  
  def about
    render :about
  end
  
  def links
    render text: "links"
  end
end
