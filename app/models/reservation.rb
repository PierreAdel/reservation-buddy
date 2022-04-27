class Reservation < ApplicationRecord
  belongs_to :hotel
  belongs_to :customer

  before_create :calculate_total_price
  before_update :calculate_total_price

  validates :number_of_days,
            presence: true,
            numericality: {
              greater_than: 0,
              less_than_or_equal_to: 100
            }

  # validates :total_price, presence: true, numericality: { greater_than: 0 }
  validates_date :date_from, on_or_after: :today # See Restriction Shorthand.

  def calculate_total_price
    self.total_price = hotel.price_per_night * number_of_days
  end
end
