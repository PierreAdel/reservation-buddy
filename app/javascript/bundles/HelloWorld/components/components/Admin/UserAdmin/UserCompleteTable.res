open CustomersHooks

@react.component
let make = (
  ~page: int,
  ~search: string,
  ~handleChangePage,
  ~handleChangeSearch,
  ~sort: string,
  ~handleChangeSort,
) => {
  let customersData = CustomersHooks.useGetCustomersHook(search, page, 10, sort)

  let content = switch customersData {
  | {isLoading: true} => React.null
  | {data: Some(result), isLoading: false, isError: false} => <>
      <UserUpperTableArea
        search={search}
        handleChangeSearch={handleChangeSearch}
        sort={sort}
        handleChangeSort={handleChangeSort}
      />
      <UserMiddleTableArea result={result} />
      <LowerTableArea
        page={page}
        handleChangePage={handleChangePage}
        maxPage={result.pages}
        rows={result.data->Belt.Array.length}
      />
    </>
  | _ => React.null
  }

  content
}
