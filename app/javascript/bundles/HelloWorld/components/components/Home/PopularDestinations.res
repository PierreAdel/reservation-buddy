type card = {
  city: string,
  imgSrc: string,
}

@react.component
let make = (~setCity) => {
  let arr = [
    {
      city: "Cairo",
      imgSrc: "../../../../../../assets/cairo.jpg",
    },
    {
      city: "Giza",
      imgSrc: "../../../../../../assets/giza.jpg",
    },
    {
      city: "Alexandria",
      imgSrc: "../../../../../../assets/alexandria.jpg",
    },
    {
      city: "Aswan",
      imgSrc: "../../../../../../assets/aswan.jpg",
    },
    {
      city: "Luxor",
      imgSrc: "../../../../../../assets/luxor.jpg",
    },
    {
      city: "Sharm El-Sheikh",
      imgSrc: "../../../../../../assets/sharm.jpg",
    },
  ]
  <div className={"Popular"}>
    <h4 className={"PopularText"}> {"Popular destinations"->React.string} </h4>
    <div className={"Cards"}>
      {arr
      ->Belt.Array.map(el =>
        <div onClick={_ => setCity(_ => el.city)} key={el.city} className={"Card"}>
          <img src={el.imgSrc} className={"CardImage"} alt={el.city} />
          <p className={"CardText"}> {el.city->React.string} </p>
        </div>
      )
      ->React.array}
    </div>
  </div>
}
