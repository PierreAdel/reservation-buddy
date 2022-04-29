open SessionsHooks
%%raw("import './Home.css'")
@react.component
let make = () => {
  let (city, setCity) = React.useState(_ => "")
  let (dateFrom, setDateFrom) = React.useState(_ => "")
  let (numOfNights, setNumOfNights) = React.useState(_ => 0)
  let userLoggedInHook = SessionsHooks.useGetUserLoggedInHook()

  let resetSearch = _ => {
    setCity(_ => "")
    setDateFrom(_ => "")
    setNumOfNights(_ => 0)
    RescriptReactRouter.push("/")
  }
  let handleChangeNumOfNights = e => {
    let newValue = ReactEvent.Form.target(e)["value"]
    if newValue > 0 && newValue <= 100 {
      setNumOfNights(newValue)
    }
  }
  React.useEffect3(() => {
    RescriptReactRouter.push(
      `?city=${city}&date_from=${dateFrom}&number_of_nights=${numOfNights->Belt.Int.toString}`,
    )
    None
  }, (city, dateFrom, numOfNights))

  <div className={"HomeContainer"}>
    <NavigationBar resetSearch={resetSearch} />
    <div className={"MiddleArea"}>
      <SearchArea
        city={city}
        dateFrom={dateFrom}
        numOfNights={numOfNights}
        handleChange={e => setCity(ReactEvent.Form.target(e)["value"])}
        handleChangeFrom={e => {
          if Js.Date.fromString(ReactEvent.Form.target(e)["value"]) > Js.Date.make() {
            setDateFrom(ReactEvent.Form.target(e)["value"])
          }
        }}
        handleChangeNumOfNights={handleChangeNumOfNights}
      />
      {city != "" && dateFrom != "" && numOfNights > 0
        ? <SearchResultCards city={city} dateFrom={dateFrom} numOfNights={numOfNights} />
        : <>
            <PopularDestinations setCity={setCity} />
            <LineArea />
            <PopularSnapshotArea setCity={setCity} />
            {switch userLoggedInHook {
            | {isLoading: true} => React.null
            | {data: Some(result), isLoading: false, isError: false} =>
              result.logged_in ? <PastReservations /> : React.null

            | _ => React.null
            }}
          </>}
    </div>
  </div>
}
