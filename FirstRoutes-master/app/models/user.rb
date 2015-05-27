class User < ActiveRecord::Base

  has_many(
    :contacts,
    class_name: "Contact",
    foreign_key: :user_id,
    primary_key: :id
  )

  # join table: mapping all contacts others have share with
  # this user
  has_many(
    :contact_shares,
    class_name: "ContactShare",
    foreign_key: :user_id,
    primary_key: :id,
    dependent: :destroy
  )

  # set of contacts thare have been shared with a user
  # NOT the set of contact that a user has shared with others
  has_many(
    :shared_contacts,
    through: :contact_shares,
    source: :shared_contact
  )

  validates :username, uniqueness: true, presence: true
end
