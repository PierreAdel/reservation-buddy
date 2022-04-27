open Reservation
@react.component
let make = (~el: Reservation.reservation) => {
  <tr key={el.id->Belt.Int.toString}>
    // <td> {"Delete"->React.string} </td>
    <td> {el.id->Belt.Int.toString->React.string} </td>
    <td> {el.date_from->React.string} </td>
    <td> {el.number_of_days->Belt.Int.toString->React.string} </td>
    <td> {el.price_per_night->Belt.Float.toString->React.string} </td>
    <td> {el.total_price->Belt.Float.toString->React.string} </td>
    <td> {el.customer_name->React.string} </td>
    <td> {el.hotel_name->React.string} </td>
    <td> {el.hotel_city->React.string} </td>
    <td> {el.created_at->Js.Date.fromString->Js.Date.toDateString->React.string} </td>
  </tr>
}
