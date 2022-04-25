@react.component
let make = (~search: string, ~handleChangeSearch, ~sort: string, ~handleChangeSort) => {
  let (show, setShow) = React.useState(_ => false)

  <div className={"UpperTableArea"}>
    <button onClick={_ => setShow(_ => true)} className={"UpperTableButton"}>
      {"Add User"->React.string}
    </button>
    //   <button className={"UpperTableButton"}> {"Sort by"->React.string} </button>
    <select value={sort} onChange={handleChangeSort} className={"UpperTableInput"}>
      <option value="+createdAt"> {"Created At (Asc)"->React.string} </option>
      <option value="-createdAt"> {"Created At (Desc)"->React.string} </option>
      <option value="+name"> {"Name"->React.string} </option>
    </select>
    <input
      value={search}
      onChange={handleChangeSearch}
      className={"UpperTableInput"}
      placeholder="Search"
    />
    {show ? <GenericForm clicked={_ => setShow(_ => false)} /> : React.null}
  </div>
}
