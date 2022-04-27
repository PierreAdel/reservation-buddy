open Reservation
@react.component
let make = (~result: Reservation.reservations) => {
  <table>
    <tr>
      // <th> {"Actions"->React.string} </th>
      <th> {"Id"->React.string} </th>
      <th> {"Date From"->React.string} </th>
      <th> {"Number of nights"->React.string} </th>
      <th> {"Price per night"->React.string} </th>
      <th> {"Total price"->React.string} </th>
      <th> {"Customer name"->React.string} </th>
      <th> {"Hotel name"->React.string} </th>
      <th> {"Hotel City"->React.string} </th>
      <th> {"Reserved at"->React.string} </th>
    </tr>
    {result.data->Belt.Array.map(el => <ReservationTableCard el={el} />)->React.array}
  </table>
}
