open SessionsHooks
@react.component
let make = (~resetSearch) => {
  let userLoggedInHook = SessionsHooks.useGetUserLoggedInHook()

  let content = switch userLoggedInHook {
  | {isLoading: true} => React.null
  | {data: Some(result), isLoading: false, isError: false} =>
    result.logged_in
      ? <div className={"RightArea"}>
          {`Hello, ${result.user.name}`->React.string}
          <span> {"  |  "->React.string} </span>
          <span style={ReactDOM.Style.make(~color="grey", ())}>
            <a
              style={ReactDOM.Style.make(~textDecoration="underline", ~cursor="pointer", ())}
              onClick={SessionsHooks.useHandleUserLogout}>
              {"Logout"->React.string}
            </a>
          </span>
        </div>
      : <div className={"RightArea"}>
          <span style={ReactDOM.Style.make(~color="grey", ())}>
            <a href={"/login"}> {"User login"->React.string} </a>
          </span>
          <span> {"  |  "->React.string} </span>
          <span style={ReactDOM.Style.make(~color="grey", ())}>
            <a href={"/register"}> {"User register"->React.string} </a>
          </span>
          <span> {"  |  "->React.string} </span>
          <span style={ReactDOM.Style.make(~color="grey", ())}>
            <a href={"/admin_login"}> {"Admin login"->React.string} </a>
          </span>
          // <span> {"Switch language"->React.string} </span>
        </div>

  | _ => React.null
  }

  <div className={"NavigationBar"}>
    <img src={"../../../../../assets/new-logo.png"} onClick={resetSearch} className={"Logo"} />
    content
  </div>
}
