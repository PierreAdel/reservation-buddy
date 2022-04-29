open Hotel
open Endpoints

module FetchData = {
  type response

  @send external json: response => Js.Promise.t<'a> = "json"
  @val external fetch: string => Js.Promise.t<response> = "fetch"
}

module HotelsHooks = {
  let useGetHotelsHook = (search, page, limit, sort) => {
    let fetchHotels = (_): Js.Promise.t<Hotel.hotels> => {
      FetchData.fetch(
        `${Endpoints.hotelsEndpoint}?search=${search}&page=${page->Belt.Int.toString}&limit=${limit->Belt.Int.toString}&sort=${sort}`,
      )->Promise.then(FetchData.json)
    }
    ReactQuery.useQuery(
      ReactQuery.queryOptions(
        ~queryFn=fetchHotels,
        ~queryKey=`${search}-${page->Belt.Int.toString}-${limit->Belt.Int.toString}-${sort}-hotels`,
        ~refetchOnWindowFocus=ReactQuery.refetchOnWindowFocus(#bool(true)),
        (),
      ),
    )
  }

  let useGetHotelHook = slug => {
    let fetchHotel = (_): Js.Promise.t<Hotel.hotel> => {
      FetchData.fetch(`${Endpoints.hotelsEndpoint}/${slug}`)->Promise.then(FetchData.json)
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

  let useHandleAddHotel = (
    hotelName,
    hotelDescription,
    pricePerNight,
    coverImageUrl,
    city,
    score,
  ) => {
    let payload = Js.Dict.empty()
    Js.Dict.set(payload, "hotel_name", Js.Json.string(hotelName))
    Js.Dict.set(payload, "description", Js.Json.string(hotelDescription))
    Js.Dict.set(payload, "price_per_night", Js.Json.string(pricePerNight->Belt.Float.toString))
    Js.Dict.set(payload, "cover_image_url", Js.Json.string(coverImageUrl))
    Js.Dict.set(payload, "city", Js.Json.string(city))
    Js.Dict.set(payload, "score", Js.Json.string(score->Belt.Float.toString))
    let _ =
      Fetch.fetchWithInit(
        Endpoints.hotelsEndpoint,
        Fetch.RequestInit.make(
          ~method_=Post,
          ~body=Fetch.BodyInit.make(Js.Json.stringify(Js.Json.object_(payload))),
          ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
          (),
        ),
      )->Js.Promise.then_(Fetch.Response.json, _)
  }

  let useHandleDeleteHotel = (slug, setShow) => {
    let _ =
      Fetch.fetchWithInit(
        `${Endpoints.hotelsEndpoint}/${slug}`,
        Fetch.RequestInit.make(
          ~method_=Delete,
          ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
          (),
        ),
      )->Js.Promise.then_(Fetch.Response.json, _)
    setShow(_ => false)
    // RescriptReactRouter.replace("/admin?table=hotels")
  }
}
