class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :visited_url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    Proc.new { distinct }, #<<<
    through: :visits,
    source: :user
  )

  def self.random_code
    rand = SecureRandom::urlsafe_base64
    while exists?(rand)
      rand = SecureRandom::urlsafe_base64
    end
    rand
  end

  def self.create_for_user_and_long_url!(user, long_url)
    submitter_id = user.id
    short_url = random_code
    ShortenedUrl.create!(submitter_id: user.id, long_url: long_url,
                         short_url: short_url)
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visitors.where(['visits.created_at >=
      ?', 10.minutes.ago]).count
  end
end
