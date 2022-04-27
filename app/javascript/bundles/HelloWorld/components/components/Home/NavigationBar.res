open SessionsHooks
@react.component
let make = () => {
  let handleSubmit = _ => {
    let _ =
      Fetch.fetchWithInit(
        `/api/v1/sessions/user_logout`,
        Fetch.RequestInit.make(~method_=Delete, ()),
      )
      ->Js.Promise.then_(_ => Js.Promise.resolve(Fetch.Response.json), _)
      ->Js.Promise.then_(_ => Js.Promise.resolve(RescriptReactRouter.replace("/login")), _)
  }

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
              onClick={handleSubmit}>
              {"Logout"->React.string}
            </a>
          </span>
        </div>
      : <div className={"RightArea"}>
          <span style={ReactDOM.Style.make(~color="grey", ())}>
            <a href={"/login"}> {"Login as User"->React.string} </a>
          </span>
          <span> {"  |  "->React.string} </span>
          <span style={ReactDOM.Style.make(~color="grey", ())}>
            <a href={"/register"}> {"Register a new User"->React.string} </a>
          </span>
          <span> {"  |  "->React.string} </span>
          <span style={ReactDOM.Style.make(~color="grey", ())}>
            <a href={"/admin_login"}> {"Login as Admin"->React.string} </a>
          </span>
          // <span> {"Switch language"->React.string} </span>
        </div>

  | _ => React.null
  }

  <div className={"NavigationBar"}>
    <img
      src={"../../../../../assets/new-logo.png"}
      onClick={_ => RescriptReactRouter.push("/")}
      className={"Logo"}
    />
    content
  </div>
}
