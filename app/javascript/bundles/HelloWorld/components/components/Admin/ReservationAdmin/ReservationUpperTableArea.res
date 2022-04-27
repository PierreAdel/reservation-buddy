@react.component
let make = (~search: string, ~handleChangeSearch, ~sort: string, ~handleChangeSort) => {
  let url = RescriptReactRouter.useUrl()

  <div className={"UpperTableArea"}>
    //   <button className={"UpperTableButton"}> {"Sort by"->React.string} </button>
    <select value={sort} onChange={handleChangeSort} className={"UpperTableInput"}>
      <option value="created_at"> {"Sort by Created at"->React.string} </option>
      <option value="number_of_days"> {"Sort by Number of days"->React.string} </option>
      <option value="total_price"> {"Sort by Total price"->React.string} </option>
      <option value="date_from"> {"Sort by Date from"->React.string} </option>
    </select>
    <input
      value={search}
      onChange={handleChangeSearch}
      className={"UpperTableInput"}
      placeholder="Search by Customer name"
    />
  </div>
}
