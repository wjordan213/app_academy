require 'bcrypt'

class User < ActiveRecord::Base
  include Commentable
  validates :session_token, :username, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :username, :session_token, uniqueness: true

  after_initialize :ensure_session_token

  has_many :goals

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user
    user.is_password?(password[1]) ? user : nil
  end


  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  attr_reader :password

  def complete_goals
    self.goals.where("completed = ?", true)
  end

  def incomplete_goals
    self.goals.where("completed = ?", false)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end


end
