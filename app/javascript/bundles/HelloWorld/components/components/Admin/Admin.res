%%raw("import './Admin.css'")

module Fetch = {
  type response

  @send external json: response => Js.Promise.t<'a> = "json"
  @val external fetch: string => Js.Promise.t<response> = "fetch"
}
type poundCake = {
  userId: int,
  id: int,
  title: string,
  completed: bool,
}
type todo = {data: array<poundCake>}

@react.component
let make = () => {
  let apiUrl = "https://jsonplaceholder.typicode.com/todos/1"

  let fetchData = (_): Js.Promise.t<todo> => {
    Fetch.fetch(apiUrl)->Js.Promise.then_(Fetch.json, _)
  }
  let loadingTodo: poundCake = {
    userId: 1,
    id: 2,
    title: "string",
    completed: true,
  }
  let errorTodo: poundCake = {
    userId: 1,
    id: 2,
    title: "string",
    completed: true,
  }

  let queryResult = ReactQuery.useQuery(
    ReactQuery.queryOptions(
      ~queryFn=fetchData,
      ~queryKey="data",
      ~refetchOnWindowFocus=ReactQuery.refetchOnWindowFocus(#bool(false)),
      (),
    ),
  )
  // let info = switch queryResult {
  // | {isLoading: true} => loadingTodo
  // | {data: Some(todo), isLoading: false, isError: false} => poundCake
  // | _ => errorTodo
  // }
  // Js.log(info.id)
  let (table, setTable) = React.useState(_ => "")
  let (sort, setSort) = React.useState(_ => "")
  let (search, setSearch) = React.useState(_ => "")
  let (page, setPage) = React.useState(_ => 1)
  // let url = RescriptReactRouter.useUrl()
  let handleChangeSort = event => {
    let newValue = ReactEvent.Form.target(event)["value"]
    setSort(newValue)
  }
  let handleChangeSearch = event => {
    let newValue = ReactEvent.Form.target(event)["value"]
    setSearch(newValue)
  }
  let maxPage = 5
  let handleChangePage = newValue => {
    if newValue > 0 && newValue <= maxPage {
      setPage(_ => newValue)
    }
  }
  React.useEffect4(() => {
    RescriptReactRouter.push(
      `${table != "" || sort != "" || search != "" || page != 1 ? "?" : ""}${table != ""
          ? "&table=" ++ table
          : ""}${sort != "" ? "&sort=" ++ sort : ""}${search != ""
          ? "&search=" ++ search
          : ""}${page != 1 ? "&page=" ++ page->Js.Int.toString : ""}`,
    )
    None
  }, (table, sort, search, page))

  <div className={"grid-container"}>
    <LeftColumn table={table} setTable={setTable} />
    <div className="TableArea">
      <span className={"TableTitleText"}> {"Users Table"->React.string} </span>
      <UpperTableArea
        search={search}
        handleChangeSearch={handleChangeSearch}
        sort={sort}
        handleChangeSort={handleChangeSort}
      />
      <MiddleTableArea />
      <LowerTableArea page={page} handleChangePage={handleChangePage} maxPage={maxPage} />
    </div>
  </div>
}
