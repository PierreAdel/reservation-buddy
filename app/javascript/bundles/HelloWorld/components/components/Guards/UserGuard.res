open SessionsHooks

@react.component
let make = (~children) => {
  let userLoggedInHook = SessionsHooks.useGetUserLoggedInHook()
  switch userLoggedInHook {
  | {data: Some(result), isLoading: false, isError: false} =>
    result.logged_in ? RescriptReactRouter.replace("/") : ()
  | _ => ()
  }

  switch userLoggedInHook {
  | {isLoading: true} => React.null
  | {data: Some(result), isLoading: false, isError: false} =>
    result.logged_in ? <> {""->React.string} </> : children
  | _ => React.null
  }
}
