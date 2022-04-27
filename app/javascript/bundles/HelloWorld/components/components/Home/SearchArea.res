@react.component
let make = (
  ~city: string,
  ~dateFrom: string,
  ~numOfNights: int,
  ~handleChange,
  ~handleChangeFrom,
  ~handleChangeNumOfNights,
) => {
  <div className={"Hero"}>
    <div className={"SearchArea"}>
      <h3 className={"SearchTitleText"} style={ReactDOM.Style.make(~color="#ff4b00", ())}>
        {"Where to?"->React.string}
      </h3>
      <div className={"InputArea"}>
        <input
        // style={ReactDOM.Style.make(~width="35%", ())}
          placeholder="e.g. Cairo"
          className={"SearchInput"}
          value={city}
          onChange={handleChange}
          type_="text"
        />
        <input
          className={"SearchInput"} value={dateFrom} onChange={handleChangeFrom} type_="date"
        />
        <input
          placeholder="Number of nights"
          className={"SearchInput"}
          value={numOfNights->Belt.Int.toString}
          onChange={handleChangeNumOfNights}
          type_="number"
        />
        // <button
        //   className={"SearchButton"}
        //   disabled={city == "" || dateFrom == "" || numOfNights <= 0}
        //   type_="submit">
        //   {"Search"->React.string}
        // </button>
      </div>
    </div>
  </div>
}
