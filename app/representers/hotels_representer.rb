class HotelsRepresenter
  def initialize(hotels)
    @hotels = hotels
  end
  def as_json
    hotels.map do |hotel|
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
  end

  private

  attr_reader :hotels

  def complex_fn(hotels)
    "#{hotels.hotel_name} #{hotels.id}"
  end
end
