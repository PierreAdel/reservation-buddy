open HotelsHooks
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
      handleChange: e => setHotelName(ReactEvent.Form.target(e)["value"]),
      required: true,
    },
    {
      label: "Hotel description",
      type_: "text",
      value: hotelDescription,
      handleChange: e => setHotelDescription(ReactEvent.Form.target(e)["value"]),
      required: true,
    },
    {
      label: "Price per night",
      type_: "number",
      value: pricePerNight->Belt.Float.toString,
      handleChange: e => setPricePerNight(ReactEvent.Form.target(e)["value"]),
      required: true,
    },
    {
      label: "Cover image url",
      type_: "text",
      value: coverImageUrl,
      handleChange: e => setCoverImageUrl(ReactEvent.Form.target(e)["value"]),
      required: true,
    },
    {
      label: "City",
      type_: "text",
      value: city,
      handleChange: e => setCity(ReactEvent.Form.target(e)["value"]),
      required: true,
    },
    {
      label: "Score",
      type_: "number",
      value: score->Belt.Float.toString,
      handleChange: e => setScore(ReactEvent.Form.target(e)["value"]),
      required: true,
    },
  ]

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
          HotelsHooks.useHandleAddHotel(
            hotelName,
            hotelDescription,
            pricePerNight,
            coverImageUrl,
            city,
            score,
          )
          clicked(e)
        }}
        className={`GenericFormSubmit ${isDisabled() ? "Disabled" : ""}`}>
        {"Submit"->React.string}
      </button>
    </div>
  </>
}
