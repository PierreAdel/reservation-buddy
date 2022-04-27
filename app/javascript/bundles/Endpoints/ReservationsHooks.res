open Reservation
open Endpoints

module Fetch = {
  type response

  @send external json: response => Js.Promise.t<'a> = "json"
  @val external fetch: string => Js.Promise.t<response> = "fetch"
}

module ReservationsHooks = {
  let useGetMyReservationsHook = () => {
    let fetchMyReservations = (_): Js.Promise.t<array<Reservation.reservation>> => {
      Fetch.fetch(`/api/v1/reservations/my_reservations`)->Promise.then(Fetch.json)
    }
    ReactQuery.useQuery(
      ReactQuery.queryOptions(
        ~queryFn=fetchMyReservations,
        ~queryKey=`my-reservations`,
        ~refetchOnWindowFocus=ReactQuery.refetchOnWindowFocus(#bool(true)),
        (),
      ),
    )
  }

  let useGetReservationsHook = (search, page, limit, sort) => {
    let fetchReservations = (_): Js.Promise.t<Reservation.reservations> => {
      Fetch.fetch(
        `/api/v1/reservations?search=${search}&page=${page->Belt.Int.toString}&limit=${limit->Belt.Int.toString}&sort=${sort}`,
      )->Promise.then(Fetch.json)
    }
    ReactQuery.useQuery(
      ReactQuery.queryOptions(
        ~queryFn=fetchReservations,
        ~queryKey=`${search}-${page->Belt.Int.toString}-${sort}-reservations`,
        ~refetchOnWindowFocus=ReactQuery.refetchOnWindowFocus(#bool(true)),
        (),
      ),
    )
  }
}
