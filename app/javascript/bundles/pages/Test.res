
/* 
* Local bindings for fetch
*/ 
module Fetch = {
  type response

  @send external json: response => Js.Promise.t<'a> = "json"
  @val external fetch: string => Js.Promise.t<response> = "fetch"
}

type todo = {id: int, slug: string,

cover_image_url: string,
hotel_name: string,
description: string,

city: string,
score: int,
price_per_night: float,
created_at: string,
updated_at: string,
admin_id: int,
 }

let apiUrl = "/api/v1/hotels"

let fetchTodos = (_): Js.Promise.t<array<todo>> => {
  Fetch.fetch(apiUrl)->Promise.then(Fetch.json)
}


@react.component
let make =() => {


let queryResult = ReactQuery.useQuery(
      ReactQuery.queryOptions(
        ~queryFn=fetchTodos,
        ~queryKey="todos",
        /*
         * Helper functions to convert unsupported TypeScript types in ReScript
         * Check out the module ReactQuery_Utils.res
         */
        ~refetchOnWindowFocus=ReactQuery.refetchOnWindowFocus(#bool(false)),
        (),
      ),
    )
    let tttttitlte =   switch queryResult {
      | {isLoading: true} => <>{"Loading..."->React.string}</>
      | {data: Some(todo), isLoading: false, isError: false} =>
        {todo
      ->Belt.Array.map(el =>
          <p key={el.hotel_name}> {el.hotel_name->React.string} </p>
      )
      ->React.array}
      | _ => <>{`Unexpected error...`->React.string}</>
      }
    <div>
    tttttitlte
    </div>
}