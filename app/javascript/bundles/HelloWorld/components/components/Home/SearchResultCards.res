open HotelsHooks

@react.component
let make = (~city: string, ~dateFrom: string, ~numOfNights: int) => {
  let hotelsData = HotelsHooks.useGetHotelsHook(city, 1, 100, "")

  let content = switch hotelsData {
  | {isLoading: true} => React.null
  | {data: Some(result), isLoading: false, isError: false} => <>
      <h4 className={"PopularText"}> {"Your search results"->React.string} </h4>
      {result.data
      ->Belt.Array.map(el =>
        <SearchResultCard
          key={el.id->Belt.Int.toString} dateFrom={dateFrom} numOfNights={numOfNights} el={el}
        />
      )
      ->React.array}
    </>
  | _ => React.null
  }

  <div className={"Popular"}> content </div>
}
