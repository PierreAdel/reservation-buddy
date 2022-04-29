open SessionsHooks
%%raw("import './Login.css'")
@react.component
let make = () => {
  let title = "Login"
  let secondry_title = "Welcome back! Login to reserve a hotel at the lowest prices."

  let (email, setEmail) = React.useState(_ => "")
  let (password, setPassword) = React.useState(_ => "")

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
      onChange={e => setEmail(ReactEvent.Form.target(e)["value"])}
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
      onChange={e => setPassword(ReactEvent.Form.target(e)["value"])}
      className={"Input"}
      type_={"password"}
    />
    <button
      onClick={_ => SessionsHooks.useHandleUserLogin(email, password)}
      className={"Button"}
      type_={"submit"}>
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
