@react.component
let make = () => {
  <div className={"LineArea"}>
    <h4 className={"KhatTitleText"}> {"Why book with us?"->React.string} </h4>
    <div className={"InfoCards"}>
      <div className={"InfoCard"}>
        <img src={"../../../../../../assets/images/tick.png"} className={"InfoImage"} />
        <p className={"InfoText"}>
          <h4 className={"InfoTextHeader"}> {"Free cancellation"->React.string} </h4>
          <p className={"InfoTextParagraph"}> {"On most hotels"->React.string} </p>
        </p>
      </div>
      <div className={"InfoCard"}>
        <img src={"../../../../../../assets/images/price.png"} className={"InfoImage"} />
        <p className={"InfoText"}>
          <h4 className={"InfoTextHeader"}> {"Best price gurantee"->React.string} </h4>
          <p className={"InfoTextParagraph"}>
            {"Be sure of booking at the best rate"->React.string}
          </p>
        </p>
      </div>
      <div className={"InfoCard"}>
        <img src={"../../../../../../images/assets/night.png"} className={"InfoImage"} />
        <p className={"InfoText"}>
          <h4 className={"InfoTextHeader"}> {"Get a reward night"->React.string} </h4>
          <p className={"InfoTextParagraph"}> {"For every 10 nights stay"->React.string} </p>
        </p>
      </div>
    </div>
  </div>
}
