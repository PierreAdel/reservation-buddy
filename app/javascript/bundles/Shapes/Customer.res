module Customer = {
  open Reservation

  type customer = {
    id: int,
    name: string,
    email: string,
    created_at: string,
    reservations: array<Reservation.reservation>,
  }

  type customers = {
    pages: int,
    page: int,
    data: array<customer>,
  }
}
