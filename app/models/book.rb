class Book < ActiveRecord::Base
  attr_accessible :author, :description, :title, :source
  
  # You will need to use attr_accessible if you are
  # using Rails config setting `whitelist_attributes = true`
  attr_accessible :cover
  
  validates :author, :title, :presence  => true
  
  
  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :cover, styles: {
    thumb: '100x100>',
    square: '200x200#',
    full: '200X200>'
  }
  
  has_many(
    :questions,
    class_name: "Question",
    foreign_key: :book_id,
    primary_key: :id,
    inverse_of: :book,
    dependent: :destroy
  )
end
