@react.component
let make = (~table: string, ~setTable) => {
  let arr = ["Users", "Hotels", "Reservations"]
  <div className="LeftCol">
    <p className="LeftText"> {"Welcome to the admin panel"->React.string} </p>
    {arr
    ->Belt.Array.map(el =>
      <div
        className={`LeftColItem ${table == el->Js.String.toLowerCase ? "Active" : ""}`}
        onClick={_ => setTable(_ => el->Js.String.toLowerCase)}>
        {el->React.string}
      </div>
    )
    ->React.array}
  </div>
}
