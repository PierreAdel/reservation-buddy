module Hotel = {
  type hotel = {
    id: int,
    name: string,
    slug: string,
    score: float,
    price_per_night: float,
    cover_image_url: string,
    description: string,
    city: string,
    admin_id: int,
    admin_name: string,
    created_at: string,
  }

  type hotels = {
    pages: int,
    page: int,
    data: array<hotel>,
  }
}
