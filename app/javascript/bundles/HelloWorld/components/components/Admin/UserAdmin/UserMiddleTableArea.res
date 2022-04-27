open Customer
@react.component
let make = (~result: Customer.customers) => {
  <table>
    <tr>
      // <th> {"Actions"->React.string} </th>
      <th> {"Id"->React.string} </th>
      <th> {"Name"->React.string} </th>
      <th> {"Email"->React.string} </th>
      <th> {"Reservations"->React.string} </th>
      <th> {"Created at"->React.string} </th>
    </tr>
    {result.data->Belt.Array.map(el => <UserTableCard el={el} />)->React.array}
  </table>
}
