class User < ActiveRecord::Base
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :username, presence: true
  validates :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_many(
    :comments,
    class_name: "Comment",
    foreign_key: :author_id,
    primary_key: :id,
    dependent: :destroy
  )

  has_many(
    :subs,
    class_name: "Sub",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :posts,
    class_name: "Post",
    foreign_key: :user_id,
    primary_key: :id,
    dependent: :destroy
  )

  after_initialize :ensure_token

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username.last)
    raise InvalidInputError unless user && user.is_password?(password.last)
    user
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  attr_reader :password

  def ensure_token
    self.session_token ||= User.generate_session_token
  end

  def reset_token
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end

class InvalidInputError < StandardError
end
