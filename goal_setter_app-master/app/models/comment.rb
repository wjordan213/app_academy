class Comment < ActiveRecord::Base
  validates :commentable_id, :body, :commentable_type, presence: true

  belongs_to :commentable, polymorphic: true
end
