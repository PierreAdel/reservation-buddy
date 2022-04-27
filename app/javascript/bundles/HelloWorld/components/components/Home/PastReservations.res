open ReservationsHooks
@react.component
let make = () => {
  let myReservationsData = ReservationsHooks.useGetMyReservationsHook()

  let content = switch myReservationsData {
  | {isLoading: true} => React.null
  | {data: Some(result), isLoading: false, isError: false} => <>
      {result->Belt.Array.length <= 0
        ? React.null
        : <>
            <h4 className={"PopularText"}> {"Your past reservations"->React.string} </h4>
            {result
            ->Belt.Array.map(el =>
              <div key={el.id->Belt.Int.toString} className={"HotelCard"}>
                <img src={el.cover_image_url} className={"HotelImage"} />
                <div className={"ReserveCardTextArea"}>
                  <p className={"ReserveCardScore"}>
                    {`Score: ${el.score->Belt.Float.toString}`->React.string}
                  </p>
                  <p className={"ReserveCardCity"}> {`City: ${el.hotel_city}`->React.string} </p>
                  <h4 className={"ReserveCardTitle"}> {el.hotel_name->React.string} </h4>
                  <p className={"ReserveCardParagraph"}> {el.hotel_description->React.string} </p>
                </div>
                <button disabled={true} className={"PastReservedButton"}>
                  {`Reserved from ${el.date_from} for ${el.number_of_days->Belt.Int.toString} nights`->React.string}
                </button>
              </div>
            )
            ->React.array}
          </>}
    </>
  | _ => React.null
  }

  <div className={"Popular"}> content </div>
}
