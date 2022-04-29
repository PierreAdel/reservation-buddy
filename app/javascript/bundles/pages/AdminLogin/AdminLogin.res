open SessionsHooks
%%raw("import './AdminLogin.css'")
@react.component
let make = () => {
  let title = "Login"
  let secondry_title = "Welcome to Reservation buddy admin panel"

  let (email, setEmail) = React.useState(_ => "")
  let (password, setPassword) = React.useState(_ => "")

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
      onClick={_ => SessionsHooks.useHandleAdminLogin(email, password)}
      className={"Button"}
      type_={"submit"}>
      {title->React.string}
    </button>
  </AdminAuthTemplates>
}
