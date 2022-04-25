%%raw("import './Home.css'")
type destination = {
  name: string,
  imgUrl: string,
}
type catData = {id: int, userId: int, completed: bool, title: string}
module Decode = {
  open Json.Decode
  let catData = (data: Js.Json.t) => {
    id: field("id", int, data),
    userId: field("userId", int, data),
    completed: field("completed", bool, data),
    title: field("title", string, data),
  }
}
// type person = {"completed": bool, "id": int, "title": string, "userId": int}
@react.component
let make = () => {
  let (dataaaa, setData) = React.useState(_ => "")
  let (city, setCity) = React.useState(_ => "")
  let (dateFrom, setDateFrom) = React.useState(_ => "")
  let (dateTo, setDateTo) = React.useState(_ => "")

  let handleChange = event => {
    let newValue = ReactEvent.Form.target(event)["value"]
    setCity(newValue)
  }
  let handleChangeFrom = event => {
    let newValue = ReactEvent.Form.target(event)["value"]
    setDateFrom(newValue)
  }
  let handleChangeTo = event => {
    let newValue = ReactEvent.Form.target(event)["value"]
    setDateTo(newValue)
  }
  React.useEffect3(() => {
    RescriptReactRouter.push(`?city=${city}&date_from=${dateFrom}&date_to=${dateTo}`)
    None
  }, (city, dateFrom, dateTo))

  React.useEffect0(() => {
    let fetchJson = (url, decoder) =>
      Fetch.fetch(url)
      ->Js.Promise.then_(Fetch.Response.json, _)
      ->Js.Promise.then_(obj => obj->decoder->Js.Promise.resolve, _)

    let fetchCat = () => fetchJson("https://jsonplaceholder.typicode.com/todos/5", Decode.catData)

    let _ = Js.Promise.then_(dataa => Js.Promise.resolve(setData(_ => dataa.title)), _)(fetchCat())
    None
  })

  // React.useEffect1(() => {
  //   Js.log(dataaaa)
  // }, [dataaaa])
  Js.log(dataaaa)
  //
  <div className={"HomeContainer"}>
    <NavigationBar />
    <div className={"MiddleArea"}>
      <SearchArea
        city={city}
        dateFrom={dateFrom}
        dateTo={dateTo}
        handleChange={handleChange}
        handleChangeFrom={handleChangeFrom}
        handleChangeTo={handleChangeTo}
      />
      {city != "" && dateFrom != "" && dateTo != ""
        ? <SearchResultCards />
        : <>
            <PopularDestinations setCity={setCity} />
            <LineArea />
            <PopularSnapshotArea />
            <PastReservations />
          </>}
    </div>
  </div>
}
