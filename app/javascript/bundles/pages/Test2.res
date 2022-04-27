let apiUrl = "/api/v1/hotels"

type user = {sd: string}
@react.component
let make = () => {
  let payload = Js.Dict.empty()
  Js.Dict.set(payload, "email", Js.Json.string("pierreadelkamel@gmail.com"))
  Js.Dict.set(payload, "password", Js.Json.string("password1"))
  let call = _ => {
    let _ =
      Fetch.fetchWithInit(
        `/api/v1/sessions/user_login`,
        Fetch.RequestInit.make(
          ~method_=Post,
          ~body=Fetch.BodyInit.make(Js.Json.stringify(Js.Json.object_(payload))),
          ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
          (),
        ),
      )->Js.Promise.then_(Fetch.Response.json, _)
  }
  // let queryResult = ReactQuery.useMutation(
  //   ReactQuery.mutationOptions(~mutationFn=xx, ~mutationKey="todos", ()),
  // )

  <> <h1> {"sds"->React.string} </h1> <button onClick={call}> {"Login"->React.string} </button> </>
  // let queryResult = ReactQuery.useQuery(

  //       ReactQuery.queryOptions(
  //         ~queryFn=fetchTodos,
  //         ~queryKey="todos",
  //         /*
  //          * Helper functions to convert unsupported TypeScript types in ReScript
  //          * Check out the module ReactQuery_Utils.res
  //          */
  //         ~refetchOnWindowFocus=ReactQuery.refetchOnWindowFocus(#bool(false)),
  //         (),
  //       ),
  //     )
  //     let tttttitlte =   switch queryResult {
  //       | {isLoading: true} => <>{"Loading..."->React.string}</>
  //       | {data: Some(todo), isLoading: false, isError: false} =>
  //         {todo
  //       ->Belt.Array.map(el =>
  //           <p key={el.hotel_name}> {el.hotel_name->React.string} </p>
  //       )
  //       ->React.array}
  //       | _ => <>{`Unexpected error...`->React.string}</>
  //       }
  //     <div>
  //     tttttitlte
  //     </div>
}
