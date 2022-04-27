%%raw("import './Home.css'")

// type person = {"completed": bool, "id": int, "title": string, "userId": int}
@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  let (city, setCity) = React.useState(_ => "")
  let (dateFrom, setDateFrom) = React.useState(_ => "")
  let (numOfNights, setNumOfNights) = React.useState(_ => 0)

  let handleChange = event => {
    let newValue = ReactEvent.Form.target(event)["value"]
    setCity(newValue)
  }
  let handleChangeFrom = event => {
    let newValue = ReactEvent.Form.target(event)["value"]
    setDateFrom(newValue)
  }
  let handleChangeNumOfNights = event => {
    let newValue = ReactEvent.Form.target(event)["value"]
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
    <NavigationBar />
    <div className={"MiddleArea"}>
      <SearchArea
        city={city}
        dateFrom={dateFrom}
        numOfNights={numOfNights}
        handleChange={handleChange}
        handleChangeFrom={handleChangeFrom}
        handleChangeNumOfNights={handleChangeNumOfNights}
      />
      {city != "" && dateFrom != "" && numOfNights > 0
        ? <SearchResultCards city={city} dateFrom={dateFrom} numOfNights={numOfNights} />
        : <>
            <PopularDestinations setCity={setCity} />
            <LineArea />
            <PopularSnapshotArea setCity={setCity} />
            <PastReservations />
          </>}
    </div>
  </div>
}
