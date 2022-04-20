class AddReservationsAssociation < ActiveRecord::Migration[7.0]
  def change
    add_reference :reservations, :customer, foreign_key: true, null: false
    add_reference :reservations, :hotel, foreign_key: true, null: false
  end
end
