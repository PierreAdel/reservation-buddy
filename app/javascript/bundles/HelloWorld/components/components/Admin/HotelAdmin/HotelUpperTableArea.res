@react.component
let make = (~search: string, ~handleChangeSearch, ~sort: string, ~handleChangeSort) => {
  let (show, setShow) = React.useState(_ => false)

  <div className={"UpperTableArea"}>
    <button onClick={_ => setShow(_ => true)} className={"UpperTableButton"}>
      {"Add hotel"->React.string}
    </button>
    //   <button className={"UpperTableButton"}> {"Sort by"->React.string} </button>
    <select value={sort} onChange={handleChangeSort} className={"UpperTableInput"}>
      <option value="created_at"> {"Sort by Created at"->React.string} </option>
      <option value="hotel_name"> {"Sort by Name"->React.string} </option>
      <option value="score"> {"Sort by Score"->React.string} </option>
      <option value="price_per_night"> {"Sort by Price per night"->React.string} </option>
    </select>
    <input
      value={search}
      onChange={handleChangeSearch}
      className={"UpperTableInput"}
      placeholder="Search by Name"
    />
    {show ? <GenericForm clicked={_ => setShow(_ => false)} /> : React.null}
  </div>
}
