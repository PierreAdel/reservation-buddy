class ChangeDateToToNumberOfDays < ActiveRecord::Migration[7.0]
  def change
    remove_column :reservations, :date_to
    add_column :reservations, :number_of_days, :int
  end
end
