class Comment < ActiveRecord::Base
  attr_accessible :content, :question_id, :user_id, :parent_id
  
  validates :content, :question_id, :user_id, presence: true
  
  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :comments
  )
  
  belongs_to(
    :question,
    class_name: "Question",
    foreign_key: :question_id,
    primary_key: :id,
    inverse_of: :comments
  )
  
  belongs_to(
    :parent,
    class_name: "Comment",
    foreign_key: :parent_id,
    primary_key: :id,
    inverse_of: :children
  )
  
  has_many(
    :children,
    class_name: "Comment",
    foreign_key: :parent_id,
    primary_key: :id,
    inverse_of: :parent
  )
end

