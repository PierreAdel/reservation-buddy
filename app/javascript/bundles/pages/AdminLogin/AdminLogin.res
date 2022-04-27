%%raw("import './AdminLogin.css'")
@react.component
let make = () => {
  let title = "Login"
  let secondry_title = "Welcome to Reservation buddy admin panel"

  let (email, setEmail) = React.useState(_ => "")
  let (password, setPassword) = React.useState(_ => "")

  let handleChange = event => {
    let newValue = ReactEvent.Form.target(event)["value"]
    setEmail(newValue)
  }
  let handleChangePassword = event => {
    let newValue = ReactEvent.Form.target(event)["value"]
    setPassword(newValue)
  }

  let handleSubmit = _ => {
    let payload = Js.Dict.empty()
    Js.Dict.set(payload, "email", Js.Json.string(email))
    Js.Dict.set(payload, "password", Js.Json.string(password))
    let _ =
      Fetch.fetchWithInit(
        `/api/v1/sessions/admin_login`,
        Fetch.RequestInit.make(
          ~method_=Post,
          ~body=Fetch.BodyInit.make(Js.Json.stringify(Js.Json.object_(payload))),
          ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
          (),
        ),
      )
      ->Js.Promise.then_(_ => Js.Promise.resolve(Fetch.Response.json), _)
      ->Js.Promise.then_(_ => Js.Promise.resolve(RescriptReactRouter.replace("/admin")), _)
    setPassword(_ => "")
    setEmail(_ => "")
    // RescriptReactRouter.replace("/admin")
  }

  <AdminAuthTemplates title={title} secondryTitle={secondry_title}>
    <p
      className={"Text"}
      style={ReactDOM.Style.make(~marginTop="40px", ~fontSize="16px", ~color="grey", ())}>
      {"Email"->React.string}
    </p>
    <input
      name="email"
      id="email"
      value={email}
      onChange={handleChange}
      className={"Input"}
      type_={"text"}
    />
    <p
      className={"Text"}
      style={ReactDOM.Style.make(~marginTop="30px", ~fontSize="16px", ~color="grey", ())}>
      {"Password"->React.string}
    </p>
    <input
      name="password"
      id="password"
      value={password}
      onChange={handleChangePassword}
      className={"Input"}
      type_={"password"}
    />
    <button onClick={handleSubmit} className={"Button"} type_={"submit"}>
      {title->React.string}
    </button>
    // <div className={"Row"}>
    //   <p
    //     className={"Text"}
    //     style={ReactDOM.Style.make(~cursor="pointer", ~fontSize="16px", ~color="grey", ())}
    //     onClick={_ => RescriptReactRouter.push("/register")}>
    //     {"New User? Register"->React.string}
    //   </p>
    // </div>
  </AdminAuthTemplates>
}
