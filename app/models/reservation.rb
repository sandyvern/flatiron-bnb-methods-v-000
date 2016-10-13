class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"

  has_one :review

  validates :checkin, presence: true
  validates :checkout, presence: true

  def duration
    (check_out - check_in).to_i
  end

  def total_price
    listing.price * duration
  end

  private

  def guest_and_host_not_same
    if guest_id == listing.host_id
      errors.add(:guest_id, "You can't book your own apartment.")
    end
  end

end
