open Hotel
open SessionsHooks

@react.component
let make = (~el: Hotel.hotel, ~dateFrom: string, ~numOfNights: int) => {
  let userLoggedInHook = SessionsHooks.useGetUserLoggedInHook()

  let (show, setShow) = React.useState(_ => true)
  let handleSubmit = _ => {
    let payload = Js.Dict.empty()
    Js.Dict.set(payload, "date_from", Js.Json.string(dateFrom))
    Js.Dict.set(payload, "number_of_days", Js.Json.string(numOfNights->Belt.Int.toString))
    let _ =
      Fetch.fetchWithInit(
        `/api/v1/reservations/${el.slug}`,
        Fetch.RequestInit.make(
          ~method_=Post,
          ~body=Fetch.BodyInit.make(Js.Json.stringify(Js.Json.object_(payload))),
          ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
          (),
        ),
      )->Js.Promise.then_(Fetch.Response.json, _)
    setShow(_ => false)
  }

  {
    show
      ? <div key={el.slug} className={"HotelCard"}>
          <img src={el.cover_image_url} className={"HotelImage"} />
          <div className={"ReserveCardTextArea"}>
            <p className={"ReserveCardScore"}>
              {`Score: ${el.score->Belt.Float.toString}`->React.string}
            </p>
            <p className={"ReserveCardCity"}> {`City: ${el.city}`->React.string} </p>
            <h4 className={"ReserveCardTitle"}> {el.name->React.string} </h4>
            <p className={"ReserveCardParagraph"}> {el.description->React.string} </p>
          </div>
          {switch userLoggedInHook {
          | {isLoading: true} => React.null
          | {data: Some(result), isLoading: false, isError: false} =>
            result.logged_in
              ? <button onClick={handleSubmit} className={"ReserveButton"}>
                  {"Reserve Now"->React.string}
                </button>
              : <button className={"ReserveButton"}>
                  <a
                    style={ReactDOM.Style.make(~color="white", ~textDecoration="none", ())}
                    href={"/login"}>
                    {"Login as a user first to reserve"->React.string}
                  </a>
                </button>

          | _ => React.null
          }}
        </div>
      : React.null
  }
}
