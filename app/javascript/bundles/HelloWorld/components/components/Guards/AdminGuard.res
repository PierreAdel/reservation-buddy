open SessionsHooks

@react.component
let make = (~children) => {
  let adminLoggedInHook = SessionsHooks.useGetAdminLoggedInHook()
  switch adminLoggedInHook {
  | {data: Some(result), isLoading: false, isError: false} =>
    result.logged_in ? RescriptReactRouter.replace("/admin") : ()
  | _ => ()
  }

  switch adminLoggedInHook {
  | {isLoading: true} => React.null
  | {data: Some(result), isLoading: false, isError: false} =>
    result.logged_in ? <> {""->React.string} </> : children
  | _ => React.null
  }
}
