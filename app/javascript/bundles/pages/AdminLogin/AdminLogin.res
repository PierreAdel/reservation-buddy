%%raw("import './AdminLogin.css'")

@react.component
let make = () => {
  let title = "Login"
  let secondry_title = "Welcome to Reservation buddy admin panel"

  <AdminAuthTemplates title={title} secondryTitle={secondry_title}>
    <p
      className={"Text"}
      style={ReactDOM.Style.make(~marginTop="40px", ~fontSize="16px", ~color="grey", ())}>
      {"Email"->React.string}
    </p>
    <input className={"Input"} type_={"text"} />
    <p
      className={"Text"}
      style={ReactDOM.Style.make(~marginTop="30px", ~fontSize="16px", ~color="grey", ())}>
      {"Password"->React.string}
    </p>
    <input className={"Input"} type_={"password"} />
    <button className={"Button"} type_={"submit"}> {title->React.string} </button>
    <div className={"Row"}>
      <p
        className={"Text"}
        style={ReactDOM.Style.make(~cursor="pointer", ~fontSize="16px", ~color="grey", ())}
        onClick={_ => RescriptReactRouter.push("/register")}>
        {"New User? Register"->React.string}
      </p>
    </div>
  </AdminAuthTemplates>
}
