open ReservationsHooks

@react.component
let make = (
  ~page: int,
  ~search: string,
  ~handleChangePage,
  ~handleChangeSearch,
  ~sort: string,
  ~handleChangeSort,
) => {
  let reservationsData = ReservationsHooks.useGetReservationsHook(search, page, 10, sort)

  let content = switch reservationsData {
  | {isLoading: true} => React.null
  | {data: Some(result), isLoading: false, isError: false} => <>
      <ReservationUpperTableArea
        search={search}
        handleChangeSearch={handleChangeSearch}
        sort={sort}
        handleChangeSort={handleChangeSort}
      />
      <ReservationMiddleTableArea result={result} />
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
