type card = {
  score: float,
  imgSrc: string,
  title: string,
  description: string,
}

@react.component
let make = () => {
  let arr = [
    {
      score: 8.3,
      imgSrc: "../../../../../../assets/hotel-1.jpg",
      title: "Four Seasons Hotel Alexandria",
      description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Suscipit nihil ab veritatis! Sapiente cupiditate cumque nulla, velit hic dolores ex! Aliquam nostrum harum voluptatem recusandae non nobis odit odio architecto.",
    },
    {
      score: 8.0,
      imgSrc: "../../../../../../assets/hotel-2.jpg",
      title: "Four Seasons Hotel Alexandria",
      description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Suscipit nihil ab veritatis! Sapiente cupiditate cumque nulla, velit hic dolores ex! Aliquam nostrum harum voluptatem recusandae non nobis odit odio architecto.",
    },
    {
      score: 7.0,
      imgSrc: "../../../../../../assets/hotel-3.jpg",
      title: "Four Seasons Hotel Alexandria",
      description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Suscipit nihil ab veritatis! Sapiente cupiditate cumque nulla, velit hic dolores ex! Aliquam nostrum harum voluptatem recusandae non nobis odit odio architecto.",
    },
    {
      score: 9.5,
      imgSrc: "../../../../../../assets/hotel-4.jpg",
      title: "Four Seasons Hotel Alexandria",
      description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Suscipit nihil ab veritatis! Sapiente cupiditate cumque nulla, velit hic dolores ex! Aliquam nostrum harum voluptatem recusandae non nobis odit odio architecto.",
    },
  ]
  <div className={"Popular"}>
    <h4 className={"PopularText"}> {"Your search results"->React.string} </h4>
    {arr
    ->Belt.Array.map(el =>
      <div key={el.description} className={"HotelCard"}>
        <img src={el.imgSrc} className={"HotelImage"} />
        <div className={"ReserveCardTextArea"}>
          <p className={"ReserveCardScore"}>
            {`Score: ${el.score->Belt.Float.toString}`->React.string}
          </p>
          <h4 className={"ReserveCardTitle"}> {el.title->React.string} </h4>
          <p className={"ReserveCardParagraph"}> {el.description->React.string} </p>
        </div>
        <button className={"ReserveButton"}> {"Reserve Now"->React.string} </button>
      </div>
    )
    ->React.array}
  </div>
}
