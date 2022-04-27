open Customer
@react.component
let make = (~el: Customer.customer) => {
  <tr key={el.id->Belt.Int.toString}>
    // <td> {"Delete"->React.string} </td>
    <td> {el.id->Belt.Int.toString->React.string} </td>
    <td> {el.name->React.string} </td>
    <td> {el.email->React.string} </td>
    <td> {el.reservations->Belt.Array.length->Belt.Int.toString->React.string} </td>
    <td> {el.created_at->Js.Date.fromString->Js.Date.toDateString->React.string} </td>
  </tr>
}
