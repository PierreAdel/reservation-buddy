@react.component
let make = (~table: string, ~setTable) => {
  let handleSubmit = _ => {
    let _ =
      Fetch.fetchWithInit(
        `/api/v1/sessions/admin_logout`,
        Fetch.RequestInit.make(~method_=Delete, ()),
      )
      ->Js.Promise.then_(_ => Js.Promise.resolve(Fetch.Response.json), _)
      ->Js.Promise.then_(_ => Js.Promise.resolve(RescriptReactRouter.replace("/")), _)
  }

  let arr = ["Users", "Hotels", "Reservations"]
  <div className="LeftCol">
    <p className="LeftText"> {"Welcome to the admin panel"->React.string} </p>
    {arr
    ->Belt.Array.map(el =>
      <div
        key={el->Js.String.toLowerCase}
        className={`LeftColItem ${table == el->Js.String.toLowerCase ? "Active" : ""}`}
        onClick={_ => setTable(_ => el->Js.String.toLowerCase)}>
        {el->React.string}
      </div>
    )
    ->React.array}
    <p
      onClick={handleSubmit}
      className="LeftText"
      style={ReactDOM.Style.make(
        ~marginTop="40px",
        ~textDecoration="underline",
        ~cursor="pointer",
        (),
      )}>
      {"Logout"->React.string}
    </p>
  </div>
}
