class User < ActiveRecord::Base
  after_initialize :ensure_session_token
  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email[1])
    user && user.is_password?(password[1]) ? user : nil
  end

  validates :password, :session_token, :password_digest, :email, presence: true
  validates :password, length: {minimum: 6}
  validates :email, :session_token, uniqueness: true

  has_many(
    :notes,
    class_name: "Note",
    foreign_key: :user_id,
    primary_key: :id,
    dependent: :destroy
  )

  attr_reader :password

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def reset_session_token!
    self.session_token = nil
  end
end
