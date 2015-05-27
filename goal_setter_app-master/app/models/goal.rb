class Goal < ActiveRecord::Base
  validates :title, :user_id, presence: true
  validates_inclusion_of :private_or_public, in: %w(private public), message: "must be public or private"
  include Commentable
  belongs_to :user

end
