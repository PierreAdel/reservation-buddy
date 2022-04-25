@react.component
let make = (
  ~city: string,
  ~dateFrom: string,
  ~dateTo: string,
  ~handleChange,
  ~handleChangeFrom,
  ~handleChangeTo,
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
        <input className={"SearchInput"} value={dateTo} onChange={handleChangeTo} type_="date" />
        <button
          className={"SearchButton"}
          disabled={city == "" || dateFrom == "" || dateTo == ""}
          type_="submit">
          {"Search"->React.string}
        </button>
      </div>
    </div>
  </div>
}
