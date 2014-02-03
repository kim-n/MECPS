class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :avatar, :delete_avatar
  
  attr_accessor :delete_avatar
  attr_accessor :not_updating_password
  
  before_validation { avatar.clear if delete_avatar == '1' }
  
  validates :email, :name, :password_digest, :session_token, presence: true
  validates :email, uniqueness: true
  validates :password, length: { in: 6..20, message: " must be between 6 and 20 characters" }, :unless => :dont_validate_password?
  validates_format_of :email, { with: /\A.+@.+\..+\z/, message: " must be a valid email"}
  
  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    full: '200X200>'
  }
  
  validates_attachment_content_type :avatar, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'file type is not allowed (only jpeg/png/gif images)'  
  # validate :file_dimensions, :unless => "errors.any?"
  
  after_initialize :ensure_session_token
  after_initialize :ensure_activation_token
  
  
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
  
  def reset_activation_token!
    self.update_attribute(:activation_token, self.class.generate_session_token)
  end
  
  private
  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end
  
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
  
  def ensure_activation_token
    self.activation_token ||= self.class.generate_session_token
  end
  
  # def file_dimensions
  #   dimensions = Paperclip::Geometry.from_file(file.queued_for_write[:original].path)
  #   self.width = dimensions.width
  #   self.height = dimensions.height
  #   if dimensions.width < 100 && dimensions.height < 100
  #     errors.add(:file,'Width or height must be at least 50px')
  #   end
  # end
  

  
  def password
    @password
  end
  
  def dont_validate_password?
    not_updating_password || new_record?
  end
end
