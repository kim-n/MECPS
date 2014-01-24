class User < ActiveRecord::Base
  attr_accessible :email, :name, :password
  
  validates :email, :name, :password_digest, :session_token, presence: true
  validates :email, uniqueness: true
  validates :password, length: { in: 6..20, message: "password must be between 6 and 20 characters" }
  validates_format_of :email, { with: /\A.+@.+\..+\z/, message: "email must be a valid email"}
  
  after_initialize :ensure_session_token
  
  # You will need to use attr_accessible if you are
  # using Rails config setting `whitelist_attributes = true`
  attr_accessible :avatar

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  
  has_many(
    :questions,
    class_name: "Question",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :user
  ) 
  
  has_many :books, through: :questions, source: :book
  
  has_many(
    :comments,
    class_name: "Comment",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :user,
    dependent: :destroy
  )
  
  def self.find_by_credentials(email, password)
    user = User.find_by_email( email )
    return user if user && user.is_password?(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def password=(password)
    @password = password
    self.password_digest  = BCrypt::Password.create(password) unless password.blank?
  end
  
  def reset_session_token!
    self.update_attribute(:session_token, self.class.generate_session_token)
  end
  
  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
  
  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end
  
  def password
    @password
  end
  
end
