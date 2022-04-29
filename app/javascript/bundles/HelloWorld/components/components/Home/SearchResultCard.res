open Hotel
open SessionsHooks
open ReservationsHooks

@react.component
let make = (~el: Hotel.hotel, ~dateFrom: string, ~numOfNights: int) => {
  let userLoggedInHook = SessionsHooks.useGetUserLoggedInHook()

  let (show, setShow) = React.useState(_ => true)

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
              ? <button
                  onClick={_ =>
                    ReservationsHooks.useHandleReserveHook(el.slug, dateFrom, numOfNights, setShow)}
                  className={"ReserveButton"}>
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
