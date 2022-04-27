module Reservation = {
  type reservation = {
    id: int,
    date_from: string,
    number_of_days: int,
    total_price: float,
    price_per_night: float,
    customer_id: int,
    customer_name: string,
    hotel_id: int,
    hotel_name: string,
    hotel_description: string,
    hotel_city: string,
    cover_image_url: string,
    score: float,
    created_at: string,
  }

  type reservations = {
    pages: int,
    page: int,
    data: array<reservation>,
  }
}
