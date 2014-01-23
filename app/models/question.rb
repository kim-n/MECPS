class Question < ActiveRecord::Base
  attr_accessible :book_id, :description, :name, :user_id
  
  validates :book_id, :name, :user_id, presence: true
  
  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :questions
  )  
  
  belongs_to(
    :book,
    class_name: "Book",
    foreign_key: :book_id,
    primary_key: :id,
    inverse_of: :questions
  )
  
  has_many(
    :comments,
    class_name: "Question",
    foreign_key: :question_id,
    primary_key: :id,
    inverse_of: :question
  )
end
