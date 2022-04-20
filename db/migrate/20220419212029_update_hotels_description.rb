class UpdateHotelsDescription < ActiveRecord::Migration[7.0]
  def change
    change_column :hotels, :description, :text
  end
end
