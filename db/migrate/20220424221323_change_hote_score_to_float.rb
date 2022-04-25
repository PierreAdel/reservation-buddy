class ChangeHoteScoreToFloat < ActiveRecord::Migration[7.0]
  def change
    change_column :hotels, :score, :float
  end
end
