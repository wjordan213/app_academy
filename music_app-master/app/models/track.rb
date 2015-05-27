class Track < ActiveRecord::Base
  validates :album_id, :bonus_or_regular, :name, presence: true

  has_many(
    :notes,
    class_name: "Note",
    foreign_key: :track_id,
    primary_key: :id,
    dependent: :destroy
  )

  belongs_to(
    :album,
    class_name: "Album",
    foreign_key: :album_id,
    primary_key: :id
  )
end
