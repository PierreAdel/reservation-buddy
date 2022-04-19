class Reservation < ApplicationRecord
    belongs_to :hotel
    belongs_to :customer
end
