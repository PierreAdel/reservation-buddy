%%raw("import './Register.css'")
@react.component
let make = () => {
  let title = "Register"
  let secondry_title = "Aloha! Create an account to reserve a hotel at the lowest prices."

  let (name, setName) = React.useState(_ => "")
  let (email, setEmail) = React.useState(_ => "")
  let (password, setPassword) = React.useState(_ => "")

  let handleChangeName = event => {
    let newValue = ReactEvent.Form.target(event)["value"]
    setName(newValue)
  }
  let handleChangeEmail = event => {
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
    Js.Dict.set(payload, "name", Js.Json.string(name))
    Js.Dict.set(payload, "password", Js.Json.string(password))
    let _ =
      Fetch.fetchWithInit(
        `/api/v1/registrations`,
        Fetch.RequestInit.make(
          ~method_=Post,
          ~body=Fetch.BodyInit.make(Js.Json.stringify(Js.Json.object_(payload))),
          ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
          (),
        ),
      )
      ->Js.Promise.then_(_ => Js.Promise.resolve(Fetch.Response.json), _)
      ->Js.Promise.then_(_ => Js.Promise.resolve(RescriptReactRouter.replace("/")), _)

    setPassword(_ => "")
    setName(_ => "")
    setEmail(_ => "")
    // RescriptReactRouter.replace("/")
  }

  <AuthTemplates title={title} secondryTitle={secondry_title}>
    <p
      className={"Text"}
      style={ReactDOM.Style.make(~marginTop="40px", ~fontSize="16px", ~color="grey", ())}>
      {"Full Name"->React.string}
    </p>
    <input
      name="name"
      id="name"
      value={name}
      onChange={handleChangeName}
      className={"Input"}
      type_={"text"}
    />
    <p
      className={"Text"}
      style={ReactDOM.Style.make(~marginTop="30px", ~fontSize="16px", ~color="grey", ())}>
      {"Email"->React.string}
    </p>
    <input
      name="email"
      id="email"
      value={email}
      onChange={handleChangeEmail}
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
    // <p
    //   className={"Text"}
    //   style={ReactDOM.Style.make(~marginTop="30px", ~fontSize="16px", ~color="grey", ())}>
    //   {"Confirm Password"->React.string}
    // </p>
    // <input className={"Input"} type_={"password"} />
    <button onClick={handleSubmit} className={"Button"} type_={"submit"}>
      {title->React.string}
    </button>
    <div className={"Row"}>
      <p
        className={"Text"}
        style={ReactDOM.Style.make(~cursor="pointer", ~fontSize="16px", ~color="grey", ())}
        onClick={_ => RescriptReactRouter.push("/login")}>
        {"Already a user? Login"->React.string}
      </p>
    </div>
  </AuthTemplates>
}
