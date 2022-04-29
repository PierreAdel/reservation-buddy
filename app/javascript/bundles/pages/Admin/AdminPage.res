%%raw("import './Admin.css'")
module Fetch = {
  type response

  @send external json: response => Js.Promise.t<'a> = "json"
  @val external fetch: string => Js.Promise.t<response> = "fetch"
}

@react.component
let make = () => {
  let (table, setTable) = React.useState(_ => "users")
  let (sort, setSort) = React.useState(_ => "created_at")
  let (search, setSearch) = React.useState(_ => "")
  let (page, setPage) = React.useState(_ => 1)
  // let url = RescriptReactRouter.useUrl()

  // let maxPage = 5
  let handleChangePage = newValue => {
    if newValue > 0 {
      setPage(_ => newValue)
    }
  }
  React.useEffect3(() => {
    RescriptReactRouter.push(
      `${sort != "" || search != "" || page != 1 ? "?" : ""}${table != ""
          ? "?table=" ++ table
          : ""}${sort != "" ? "&sort=" ++ sort : ""}${search != ""
          ? "&search=" ++ search
          : ""}${page != 1 ? "&page=" ++ page->Js.Int.toString : ""}`,
    )
    None
  }, (sort, search, page))

  React.useEffect1(() => {
    setSearch(_ => "")
    setPage(_ => 1)
    setSort(_ => "")
    RescriptReactRouter.push(table != "" ? "?table=" ++ table : "")
    None
  }, [table])

  <div className={"grid-container"}>
    <LeftColumn table={table} setTable={setTable} />
    <div className="TableArea">
      <span className={"TableTitleText"}> {"Users Table"->React.string} </span>
      {if table == "reservations" {
        <ReservationCompleteTable
          page={page}
          search={search}
          handleChangePage={handleChangePage}
          handleChangeSearch={e => setSearch(ReactEvent.Form.target(e)["value"])}
          sort={sort}
          handleChangeSort={e => setSort(ReactEvent.Form.target(e)["value"])}
        />
      } else if table == "hotels" {
        <HotelCompleteTable
          page={page}
          search={search}
          handleChangePage={handleChangePage}
          handleChangeSearch={e => setSearch(ReactEvent.Form.target(e)["value"])}
          sort={sort}
          handleChangeSort={e => setSort(ReactEvent.Form.target(e)["value"])}
        />
      } else {
        <UserCompleteTable
          page={page}
          search={search}
          handleChangePage={handleChangePage}
          handleChangeSearch={e => setSearch(ReactEvent.Form.target(e)["value"])}
          sort={sort}
          handleChangeSort={e => setSort(ReactEvent.Form.target(e)["value"])}
        />
      }}
    </div>
  </div>
}
