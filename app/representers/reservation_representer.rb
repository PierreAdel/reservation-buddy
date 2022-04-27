class ReservationRepresenter
  def initialize(reservation)
    @reservation = reservation
  end
  def as_json
    {
      id: reservation.id,
      date_from: reservation.date_from,
      number_of_days: reservation.number_of_days,
      total_price: reservation.total_price,
      price_per_night: reservation.hotel.price_per_night,
      customer_id: reservation.customer_id,
      customer_name: reservation.customer.name,
      hotel_id: reservation.hotel_id,
      hotel_name: reservation.hotel.hotel_name,
      hotel_description: reservation.hotel.description,
      cover_image_url: reservation.hotel.cover_image_url,
      score: reservation.hotel.score,
      hotel_city: reservation.hotel.city,
    }
  end

  private

  attr_reader :reservation
end
