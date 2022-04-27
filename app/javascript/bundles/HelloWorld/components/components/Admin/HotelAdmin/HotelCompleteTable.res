open HotelsHooks

@react.component
let make = (
  ~page: int,
  ~search: string,
  ~handleChangePage,
  ~handleChangeSearch,
  ~sort: string,
  ~handleChangeSort,
) => {
  let hotelsData = HotelsHooks.useGetHotelsHook(search, page, 10, sort)

  let content = switch hotelsData {
  | {isLoading: true} => React.null
  | {data: Some(result), isLoading: false, isError: false} => <>
      <HotelUpperTableArea
        search={search}
        handleChangeSearch={handleChangeSearch}
        sort={sort}
        handleChangeSort={handleChangeSort}
      />
      <HotelMiddleTableArea result={result} />
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
