open HotelsHooks
@react.component
let make = (~setCity) => {
  let hotelsData = HotelsHooks.useGetHotelsHook("", 1, 5, "")

  let content = switch hotelsData {
  | {isLoading: true} => React.null
  | {data: Some(result), isLoading: false, isError: false} => <>
      <h4 className={"PopularText"}>
        {"A snapshot of the world's most picture-perfect properties"->React.string}
      </h4>
      <div className={"Cards"}>
        {result.data
        ->Belt.Array.map(el =>
          <div onClick={_ => setCity(_ => el.name)} key={el.slug} className={"PropertyCard"}>
            <img src={el.cover_image_url} className={"HotelCardImage"} alt=el.slug />
            <p className={"CardText"}> {el.name->React.string} </p>
            <p className={"CardTextSmall"}> {el.city->React.string} </p>
          </div>
        )
        ->React.array}
      </div>
    </>
  | _ => React.null
  }

  <div className={"Popular"}> content </div>
}
