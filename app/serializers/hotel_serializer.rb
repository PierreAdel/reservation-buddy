class HotelSerializer
  include FastJsonapi::ObjectSerializer
  attributes :hotel_name, :cover_image_url, :slug, :admin_id
end
