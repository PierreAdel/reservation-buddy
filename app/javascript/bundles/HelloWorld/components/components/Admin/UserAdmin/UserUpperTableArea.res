@react.component
let make = (~search: string, ~handleChangeSearch, ~sort: string, ~handleChangeSort) => {
  <div className={"UpperTableArea"}>
    //   <button className={"UpperTableButton"}> {"Sort by"->React.string} </button>
    <select value={sort} onChange={handleChangeSort} className={"UpperTableInput"}>
      <option value="created_at"> {"Sort by Created at"->React.string} </option>
      <option value="name"> {"Sort by Name"->React.string} </option>
      <option value="email"> {"Sort by Email"->React.string} </option>
    </select>
    <input
      value={search}
      onChange={handleChangeSearch}
      className={"UpperTableInput"}
      placeholder="Search by Name"
    />
  </div>
}
