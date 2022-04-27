@react.component
let make = (~page: int, ~handleChangePage, ~maxPage: int, ~rows: int) => {
  <div className={"LowerTableArea"}>
    <p className={"LowerTableText"}> {`Showing ${rows->Belt.Int.toString} rows`->React.string} </p>
    <p className={"LowerTableText"}>
      {`Page ${page->Js.Int.toString} of ${maxPage->Js.Int.toString}`->React.string}
    </p>
    <button
      disabled={page == 1}
      onClick={_ => handleChangePage(1)}
      className={`LowerTableButton ${page == 1 ? "Disabled" : ""}`}>
      {"First"->React.string}
    </button>
    <button
      disabled={page == 1}
      onClick={_ => handleChangePage(page - 1)}
      className={`LowerTableButton ${page == 1 ? "Disabled" : ""}`}>
      {"Previous"->React.string}
    </button>
    <button
      disabled={page == maxPage}
      onClick={_ => handleChangePage(page + 1)}
      className={`LowerTableButton ${page == maxPage ? "Disabled" : ""}`}>
      {"Next"->React.string}
    </button>
    <button
      disabled={page == maxPage}
      onClick={_ => handleChangePage(maxPage)}
      className={`LowerTableButton ${page == maxPage ? "Disabled" : ""}`}>
      {"Last"->React.string}
    </button>
  </div>
}
