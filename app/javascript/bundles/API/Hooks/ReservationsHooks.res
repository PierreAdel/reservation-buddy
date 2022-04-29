open Reservation
open Endpoints
module FetchData = {
  type response

  @send external json: response => Js.Promise.t<'a> = "json"
  @val external fetch: string => Js.Promise.t<response> = "fetch"
}

module ReservationsHooks = {
  let useGetMyReservationsHook = () => {
    let fetchMyReservations = (_): Js.Promise.t<array<Reservation.reservation>> => {
      FetchData.fetch(`${Endpoints.reservationsEndpoint}/my_reservations`)->Promise.then(
        FetchData.json,
      )
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
      FetchData.fetch(
        `${Endpoints.reservationsEndpoint}?search=${search}&page=${page->Belt.Int.toString}&limit=${limit->Belt.Int.toString}&sort=${sort}`,
      )->Promise.then(FetchData.json)
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

  let useHandleReserveHook = (slug, dateFrom, numOfNights, setShow) => {
    let payload = Js.Dict.empty()
    Js.Dict.set(payload, "date_from", Js.Json.string(dateFrom))
    Js.Dict.set(payload, "number_of_days", Js.Json.string(numOfNights->Belt.Int.toString))
    let _ =
      Fetch.fetchWithInit(
        `${Endpoints.reservationsEndpoint}/${slug}`,
        Fetch.RequestInit.make(
          ~method_=Post,
          ~body=Fetch.BodyInit.make(Js.Json.stringify(Js.Json.object_(payload))),
          ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
          (),
        ),
      )->Js.Promise.then_(Fetch.Response.json, _)
    setShow(_ => false)
  }
}
