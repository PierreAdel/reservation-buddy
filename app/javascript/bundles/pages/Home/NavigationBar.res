@react.component
let make = () => {
  <div className={"NavigationBar"}>
    <img src={"../../../../../assets/logo.png"} onClick={_ => RescriptReactRouter.push("/")} className={"Logo"} />
    <div className={"RightArea"}>
      <span style={ReactDOM.Style.make(~color="grey", ())}>
        <a href={"/login"}> {"Login"->React.string} </a>
      </span>
      <span> {"  |  "->React.string} </span>
      <span style={ReactDOM.Style.make(~color="grey", ())}>
        <a href={"/register"}> {"Register"->React.string} </a>
      </span>
      // <span> {"Switch language"->React.string} </span>
    </div>
  </div>
}
