open Hotel
open Endpoints

module FetchData = {
  type response

  @send external json: response => Js.Promise.t<'a> = "json"
  @val external fetch: string => Js.Promise.t<response> = "fetch"
}

module RegistrationsHooks = {
  let useGetHotelsHook = (search, page, limit, sort) => {
    let fetchHotels = (_): Js.Promise.t<Hotel.hotels> => {
      FetchData.fetch(
        `${Endpoints.hotelsEndpoint}?search=${search}&page=${page->Belt.Int.toString}&limit=${limit->Belt.Int.toString}&sort=${sort}`,
      )->Promise.then(FetchData.json)
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

  let useHandleUserRegister = (email, name, password) => {
    let payload = Js.Dict.empty()
    Js.Dict.set(payload, "email", Js.Json.string(email))
    Js.Dict.set(payload, "name", Js.Json.string(name))
    Js.Dict.set(payload, "password", Js.Json.string(password))
    let _ =
      Fetch.fetchWithInit(
        Endpoints.registrationsEndpoint,
        Fetch.RequestInit.make(
          ~method_=Post,
          ~body=Fetch.BodyInit.make(Js.Json.stringify(Js.Json.object_(payload))),
          ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
          (),
        ),
      )
      ->Js.Promise.then_(_ => Js.Promise.resolve(Fetch.Response.json), _)
      ->Js.Promise.then_(_ => Js.Promise.resolve(RescriptReactRouter.replace("/")), _)

    // setPassword(_ => "")
    // setName(_ => "")
    // setEmail(_ => "")
    // RescriptReactRouter.replace("/")
  }
}
