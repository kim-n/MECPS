class User < ActiveRecord::Base
  attr_accessible :email, :name, :password
  validates :email, :name, :password_digest, :session_token, presence: true
  validates :email, uniqueness: true
  validates :password, length: { in: 6..20, message: "password must be between 2 and 20 characters" }
  # validates :email, fromat: { with: /\A.+@.+\..+\z/, message: "Not a valid email" }
  validates_format_of :email, { with: /\A.+@.+\..+\z/, message: "email must be a valid email"}
  
  after_initialize :ensure_session_token
  
  def self.find_by_credentials(email, password)
    user = User.find_by_email( email )
    return user if user && user.is_password?(password)
  end
  
  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
  
  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end
  
  def password=(password)
    @password = password
    self.password_digest  = BCrypt::Password.create(password) unless password.blank?
  end
  
  def password
    @password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def reset_session_token 
    self.session_toke = self.class.generate_session_token
    self.save!
  end
end
