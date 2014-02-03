class Book < ActiveRecord::Base
  attr_accessible :author, :description, :title, :cover, :delete_cover, :source, :delete_source
  
  attr_accessor :delete_cover, :delete_source
  
  before_validation { cover.clear if delete_cover == '1' }
  before_validation { source.clear if delete_source == '1' }
  
  validates :author, :title, :presence  => true
  
  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :cover, styles: {
    thumb: '100x100>',
    square: '200x200#',
    full: '200X200>'
  }
  
  validates_attachment_content_type :cover, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'file type is not allowed (only jpeg/png/gif images)'  
  
  has_attached_file :source
  
  validates_attachment_content_type :source, :content_type => ["application/pdf","application/vnd.ms-excel",     
             "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
             "application/msword", 
             "application/vnd.openxmlformats-officedocument.wordprocessingml.document", 
             "text/plain"], :message => 'file type is not allowed'  
  
  has_many(
    :questions,
    class_name: "Question",
    foreign_key: :book_id,
    primary_key: :id,
    inverse_of: :book,
    dependent: :destroy
  )
end
