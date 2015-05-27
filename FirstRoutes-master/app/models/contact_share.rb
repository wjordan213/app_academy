class ContactShare < ActiveRecord::Base

  # this is the user that a contact has been shared WITH
  belongs_to(
    :shared_user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :shared_contact,
    class_name: "Contact",
    foreign_key: :contact_id,
    primary_key: :id
  )

  validates :user_id, presence: true, uniqueness: { scope: :contact_id }
  validates :contact_id, presence: true
end
