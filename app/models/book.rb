class Book < ActiveRecord::Base
  attr_accessible :author, :description, :image, :title
  
  validates :author, :image, :title, :presence  => true
end
