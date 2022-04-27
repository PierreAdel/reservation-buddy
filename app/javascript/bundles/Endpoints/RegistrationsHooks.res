open Hotel
open Endpoints

module Fetch = {
  type response

  @send external json: response => Js.Promise.t<'a> = "json"
  @val external fetch: string => Js.Promise.t<response> = "fetch"
}

module RegistrationsHooks = {
  let useGetHotelsHook = (search, page, limit, sort) => {
    let fetchHotels = (_): Js.Promise.t<Hotel.hotels> => {
      Fetch.fetch(
        `${Endpoints.hotelsEndpoint}?search=${search}&page=${page->Belt.Int.toString}&limit=${limit->Belt.Int.toString}&sort=${sort}`,
      )->Promise.then(Fetch.json)
    }
    ReactQuery.useQuery(
      ReactQuery.queryOptions(
        ~queryFn=fetchHotels,
        ~queryKey="hotels",
        ~refetchOnWindowFocus=ReactQuery.refetchOnWindowFocus(#bool(true)),
        (),
      ),
    )
  }

  let useGetHotelHook = slug => {
    let fetchHotel = (_): Js.Promise.t<Hotel.hotel> => {
      Fetch.fetch(`${Endpoints.hotelsEndpoint}/${slug}`)->Promise.then(Fetch.json)
    }
    ReactQuery.useQuery(
      ReactQuery.queryOptions(
        ~queryFn=fetchHotel,
        ~queryKey=`${slug}hotel`,
        ~refetchOnWindowFocus=ReactQuery.refetchOnWindowFocus(#bool(true)),
        (),
      ),
    )
  }
}
