type input = {
  label: string,
  type_: string,
  value: string,
  handleChange: ReactEvent.Form.t => unit,
  required: bool,
}
@react.component
let make = (~clicked) => {
  let (hotelName, setHotelName) = React.useState(_ => "")
  let (hotelDescription, setHotelDescription) = React.useState(_ => "")
  let (pricePerNight, setPricePerNight) = React.useState(_ => 1.0)
  let (coverImageUrl, setCoverImageUrl) = React.useState(_ => "")
  let (city, setCity) = React.useState(_ => "")
  let (score, setScore) = React.useState(_ => 0.0)

  let arr = [
    {
      label: "Hotel name",
      type_: "text",
      value: hotelName,
      handleChange: event => setHotelName(ReactEvent.Form.target(event)["value"]),
      required: true,
    },
    {
      label: "Hotel description",
      type_: "text",
      value: hotelDescription,
      handleChange: event => setHotelDescription(ReactEvent.Form.target(event)["value"]),
      required: true,
    },
    {
      label: "Price per night",
      type_: "number",
      value: pricePerNight->Belt.Float.toString,
      handleChange: event => setPricePerNight(ReactEvent.Form.target(event)["value"]),
      required: true,
    },
    {
      label: "Cover image url",
      type_: "text",
      value: coverImageUrl,
      handleChange: event => setCoverImageUrl(ReactEvent.Form.target(event)["value"]),
      required: true,
    },
    {
      label: "City",
      type_: "text",
      value: city,
      handleChange: event => setCity(ReactEvent.Form.target(event)["value"]),
      required: true,
    },
    {
      label: "Score",
      type_: "number",
      value: score->Belt.Float.toString,
      handleChange: event => setScore(ReactEvent.Form.target(event)["value"]),
      required: true,
    },
  ]

  let handleAdd = _ => {
    let payload = Js.Dict.empty()
    Js.Dict.set(payload, "hotel_name", Js.Json.string(hotelName))
    Js.Dict.set(payload, "description", Js.Json.string(hotelDescription))
    Js.Dict.set(payload, "price_per_night", Js.Json.string(pricePerNight->Belt.Float.toString))
    Js.Dict.set(payload, "cover_image_url", Js.Json.string(coverImageUrl))
    Js.Dict.set(payload, "city", Js.Json.string(city))
    Js.Dict.set(payload, "score", Js.Json.string(score->Belt.Float.toString))
    let _ =
      Fetch.fetchWithInit(
        `/api/v1/hotels`,
        Fetch.RequestInit.make(
          ~method_=Post,
          ~body=Fetch.BodyInit.make(Js.Json.stringify(Js.Json.object_(payload))),
          ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
          (),
        ),
      )->Js.Promise.then_(Fetch.Response.json, _)
  }
  let isDisabled = () => {
    hotelName == "" ||
    hotelDescription == "" ||
    pricePerNight < 1.0 ||
    coverImageUrl == "" ||
    city == "" ||
    score < 0.0
  }
  <>
    <div onClick={clicked} className={"Backdrop"} />
    <div className={"GenericForm"}>
      <p className={"GenericFormTitle"}> {"Add hotel form"->React.string} </p>
      {arr
      ->Belt.Array.map(el =>
        <React.Fragment key={el.label}>
          <p className={"Label"}> {(el.label ++ " *")->React.string} </p>
          <input
            onChange={el.handleChange}
            value={el.value}
            type_={el.type_}
            className={"UpperTableInput"}
            placeholder={el.label}
          />
        </React.Fragment>
      )
      ->React.array}
      <button
        disabled={isDisabled()}
        onClick={e => {
          handleAdd(e)
          clicked(e)
        }}
        className={`GenericFormSubmit ${isDisabled() ? "Disabled" : ""}`}>
        {"Submit"->React.string}
      </button>
    </div>
  </>
}
