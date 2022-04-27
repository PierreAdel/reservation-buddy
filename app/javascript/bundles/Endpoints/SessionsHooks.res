open Session
open Endpoints

module Fetchs = {
  type response

  @send external json: response => Js.Promise.t<'a> = "json"
  @val external fetch: string => Js.Promise.t<response> = "fetch"
}

module SessionsHooks = {
  let useGetUserLoggedInHook = () => {
    let fetchMyReservations = (_): Js.Promise.t<Session.user_session> => {
      Fetchs.fetch(`/api/v1/sessions/user_logged_in`)->Promise.then(Fetchs.json)
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
      Fetchs.fetch(`/api/v1/sessions/admin_logged_in`)->Promise.then(Fetchs.json)
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
}
