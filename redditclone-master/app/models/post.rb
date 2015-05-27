class Post < ActiveRecord::Base
  validates :user_id, :title, presence: true
  validate :at_least_one_sub

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :comments,
    class_name: "Comment",
    foreign_key: :post_id,
    primary_key: :id,
    dependent: :destroy
  )

  has_many(
    :post_subs,
    class_name: "PostSub",
    foreign_key: :post_id,
    primary_key: :id,
    dependent: :destroy,
    inverse_of: :post
  )

  has_many(
    :subs,
    through: :post_subs,
    source: :sub
  )

  def comments_by_parent_id
    organized_comments = Hash.new { |h, k| h[k] = [] }
    coms = comments.includes(:author)
    coms.each do |comment|
      organized_comments[comment.parent_comment_id] << comment
    end
    organized_comments
  end

  private

  def at_least_one_sub
    errors[:subs] << "post needs at least one sub" if subs.none?
  end
end
