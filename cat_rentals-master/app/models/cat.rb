class Cat < ActiveRecord::Base
  SEX = ['m', 'f']
  COLORS = ['black', 'brown', 'orange', 'grey', 'white', 'orange with black strips' ]

  has_many :cat_rental_requests, dependent: :destroy
  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  validates :color, :name, :sex, :user_id, :presence => true
  validates :color, :inclusion =>  { in: COLORS }
  validates :sex, :inclusion =>    { in: SEX }

  def age
    Time.new.year - birth_date.year
  end







end
