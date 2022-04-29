open Session
open Endpoints

module FetchData = {
  type response

  @send external json: response => Js.Promise.t<'a> = "json"
  @val external fetch: string => Js.Promise.t<response> = "fetch"
}

module SessionsHooks = {
  let useGetUserLoggedInHook = () => {
    let fetchMyReservations = (_): Js.Promise.t<Session.user_session> => {
      FetchData.fetch(`${Endpoints.sessionsEndpoint}/user_logged_in`)->Promise.then(FetchData.json)
    }
    ReactQuery.useQuery(
      ReactQuery.queryOptions(
        ~queryFn=fetchMyReservations,
        ~queryKey=`user_logged_in`,
        ~refetchOnWindowFocus=ReactQuery.refetchOnWindowFocus(#bool(true)),
        (),
      ),
    )
  }

  let useGetAdminLoggedInHook = () => {
    let fetchMyReservations = (_): Js.Promise.t<Session.admin_session> => {
      FetchData.fetch(`${Endpoints.sessionsEndpoint}/admin_logged_in`)->Promise.then(FetchData.json)
    }
    ReactQuery.useQuery(
      ReactQuery.queryOptions(
        ~queryFn=fetchMyReservations,
        ~queryKey=`admin_logged_in`,
        ~refetchOnWindowFocus=ReactQuery.refetchOnWindowFocus(#bool(true)),
        (),
      ),
    )
  }

  let handleAdminLogout = _ => {
    let _ =
      Fetch.fetchWithInit(
        `${Endpoints.sessionsEndpoint}/admin_logout`,
        Fetch.RequestInit.make(~method_=Delete, ()),
      )
      ->Js.Promise.then_(_ => Js.Promise.resolve(Fetch.Response.json), _)
      ->Js.Promise.then_(_ => Js.Promise.resolve(RescriptReactRouter.replace("/")), _)
  }

  let useHandleAdminLogin = (email, password) => {
    let payload = Js.Dict.empty()
    Js.Dict.set(payload, "email", Js.Json.string(email))
    Js.Dict.set(payload, "password", Js.Json.string(password))
    let _ =
      Fetch.fetchWithInit(
        `${Endpoints.sessionsEndpoint}/admin_login`,
        Fetch.RequestInit.make(
          ~method_=Post,
          ~body=Fetch.BodyInit.make(Js.Json.stringify(Js.Json.object_(payload))),
          ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
          (),
        ),
      )
      ->Js.Promise.then_(_ => Js.Promise.resolve(Fetch.Response.json), _)
      ->Js.Promise.then_(_ => Js.Promise.resolve(RescriptReactRouter.replace("/admin")), _)
    // setPassword(_ => "")
    // setEmail(_ => "")
    // RescriptReactRouter.replace("/admin")
  }

  let useHandleUserLogin = (email, password) => {
    let payload = Js.Dict.empty()
    Js.Dict.set(payload, "email", Js.Json.string(email))
    Js.Dict.set(payload, "password", Js.Json.string(password))
    let _ =
      Fetch.fetchWithInit(
        `${Endpoints.sessionsEndpoint}/user_login`,
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
    // setEmail(_ => "")
  }

  let useHandleUserLogout = _ => {
    let _ =
      Fetch.fetchWithInit(
        `${Endpoints.sessionsEndpoint}/user_logout`,
        Fetch.RequestInit.make(~method_=Delete, ()),
      )
      ->Js.Promise.then_(_ => Js.Promise.resolve(Fetch.Response.json), _)
      ->Js.Promise.then_(_ => Js.Promise.resolve(RescriptReactRouter.replace("/login")), _)
  }
}
