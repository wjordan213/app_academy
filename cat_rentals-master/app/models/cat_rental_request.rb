class CatRentalRequest < ActiveRecord::Base
  STATUS = %w( APPROVED DENIED PENDING)

  belongs_to :user
  belongs_to :cat

  validates :cat_id, :start_date, :end_date, :user_id, :presence => true
  validates :status, :inclusion => { in: STATUS }
  validate :overlapping_approved_requests


  def overlapping_requests
    CatRentalRequest
      .where('cat_id = ?', self.cat_id)
      .where('NOT(? < start_date OR ? > end_date)', self.end_date, self.start_date)
  end

  def overlapping_approved_requests

    if overlapping_requests.exists?(status: 'APPROVED')
      errors[:status] << 'overlap'
    end
  end

end
