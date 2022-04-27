%%raw("import './Login.css'")

@react.component
let make = () => {
  let title = "Login"
  let secondry_title = "Welcome back! Login to reserve a hotel at the lowest prices."

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

  let handleSubmit = e => {
    let payload = Js.Dict.empty()
    Js.Dict.set(payload, "email", Js.Json.string(email))
    Js.Dict.set(payload, "password", Js.Json.string(password))
    let x =
      Fetch.fetchWithInit(
        `/api/v1/sessions/user_login`,
        Fetch.RequestInit.make(
          ~method_=Post,
          ~body=Fetch.BodyInit.make(Js.Json.stringify(Js.Json.object_(payload))),
          ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
          (),
        ),
      )->Js.Promise.then_(Fetch.Response.json, _)
    setPassword(_ => "")
    setEmail(_ => "")
    RescriptReactRouter.replace("/")
  }

  <AuthTemplates title={title} secondryTitle={secondry_title}>
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
    <div className={"Row"}>
      <p
        className={"Text"}
        style={ReactDOM.Style.make(~cursor="pointer", ~fontSize="16px", ~color="grey", ())}
        onClick={_ => RescriptReactRouter.push("/register")}>
        {"New User? Register"->React.string}
      </p>
    </div>
  </AuthTemplates>
}
