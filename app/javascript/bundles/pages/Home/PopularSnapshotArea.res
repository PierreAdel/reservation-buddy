type card = {
  city: string,
  hotel: string,
  imgSrc: string,
}

@react.component
let make = () => {
  let arr = [
    {
      city: "Cairo",
      hotel: "Hilton resort",
      imgSrc: "../../../../../../assets/hotel-1.jpg",
    },
    {
      city: "Alexandria",
      hotel: "Four Seasons Hotel Alexandria",
      imgSrc: "../../../../../../assets/hotel-2.jpg",
    },
    {
      city: "Aswan",
      hotel: "Hilton Nile view Aswan",
      imgSrc: "../../../../../../assets/hotel-3.jpg",
    },
    {
      city: "Maldives",
      hotel: "Hilton Maldives",
      imgSrc: "../../../../../../assets/maldives.jpg",
    },
    {
      city: "Luxor",
      hotel: "Sonesta St George Hotel Luxo",
      imgSrc: "../../../../../../assets/hotel-4.jpg",
    },
  ]
  <div className={"Popular"}>
    <h4 className={"PopularText"}>
      {"A snapshot of the world's most picture-perfect properties"->React.string}
    </h4>
    <div className={"Cards"}>
      {arr
      ->Belt.Array.map(el =>
        <div key={el.hotel} className={"PropertyCard"}>
          <img src={el.imgSrc} className={"HotelCardImage"} alt=el.hotel />
          <p className={"CardText"}> {el.hotel->React.string} </p>
          <p className={"CardTextSmall"}> {el.city->React.string} </p>
        </div>
      )
      ->React.array}
    </div>
  </div>
}
