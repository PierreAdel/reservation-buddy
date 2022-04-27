class HotelRepresenter
  def initialize(hotel)
    @hotel = hotel
  end
  def as_json
    {
      id: hotel.id,
      name: hotel.hotel_name,
      slug: hotel.slug,
      score: hotel.score,
      price_per_night: hotel.price_per_night,
      cover_image_url: hotel.cover_image_url,
      description: hotel.description,
      city: hotel.city,
      # name_plus_id: complex_fn(hotel),
      admin_id: hotel.admin_id,
      admin_name: hotel.admin.name,
    }
  end

  private

  attr_reader :hotel

  def complex_fn(hotel)
    "#{hotel.hotel_name} #{hotel.id}"
  end
end
