module Customer = {
  open Reservation

  type customer = {
    id: int,
    name: string,
    email: string,
    reservations: array<Reservation.reservation>,
  }

  type customers = {
    pages: int,
    page: int,
    data: array<customer>,
  }
}
