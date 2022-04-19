class CreateHotels < ActiveRecord::Migration[7.0]
  def change
    create_table :hotels do |t|
      t.string :slug
      t.string :cover_image_url
      t.string :description
      t.string :hotel_name
      t.string :city
      t.float :score
      t.float :price_per_night

      t.timestamps
    end
  end
end
