class Contact < ActiveRecord::Base

  # this is the (original) user that is the owner of a contact
  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  # join table: association between contact and users with whom
  # the contact has been shared
  has_many(
    :contact_shares,
    class_name: "ContactShare",
    foreign_key: :contact_id,
    primary_key: :id
  )

  # the set of users with whom a contact has been shared
  has_many(
    :shared_users,
    through: :contact_shares,
    source: :shared_user
  )

  validates :email, presence: true, uniqueness: { scope: :user_id }
  validates :name, presence: true
end
