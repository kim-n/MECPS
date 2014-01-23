class Book < ActiveRecord::Base
  attr_accessible :author, :description, :image, :title
  
  validates :author, :image, :title, :presence  => true
  
  has_many(
    :questions,
    class_name: "Question",
    foreign_key: :book_id,
    primary_key: :id,
    inverse_of: :book,
    dependent: :destroy
  )
end
