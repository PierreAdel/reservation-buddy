open SessionsHooks

@react.component
let make = (~children) => {
  let adminLoggedInHook = SessionsHooks.useGetAdminLoggedInHook()
  switch adminLoggedInHook {
  | {data: Some(result), isLoading: false, isError: false} =>
    result.logged_in ? RescriptReactRouter.replace("/") : Js.log("asd")
  | _ => Js.log("asd")
  }

  switch adminLoggedInHook {
  | {isLoading: true} => React.null
  | {data: Some(result), isLoading: false, isError: false} =>
    result.logged_in ? <> {""->React.string} </> : children
  | _ => React.null
  }
}
