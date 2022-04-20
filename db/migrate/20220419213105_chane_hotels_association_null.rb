class ChaneHotelsAssociationNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :hotels, :admin_id, false
  end
end
