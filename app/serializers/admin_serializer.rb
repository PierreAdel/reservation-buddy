class AdminSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email, :hotel_id
  # has_many :admins
end
