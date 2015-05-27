class User < ActiveRecord::Base
  attr_reader :password

  has_many :cat_rental_requests
  has_many(
    :cats,
    class_name: "Cat",
    foreign_key: :user_id,
    primary_key: :id
  )

  validates :session_token, presence: true, uniqueness: true
  validates :user_name, uniqueness: true, presence: true
  validates :password_digest, presence: true
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  after_initialize :set_session_token

  def self.create_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by_user_name(user_name)
    if user.is_password?(password)
      user
    else
      nil
    end
  end

  def reset_session_token!
    self.session_token = User.create_session_token
    self.save!
    self.session_token

  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def set_session_token
    self.session_token ||= User.create_session_token
  end








end
