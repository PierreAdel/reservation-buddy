open Hotel
@react.component
let make = (~result: Hotel.hotels) => {
  <table>
    <tr>
      <th> {"Actions"->React.string} </th>
      <th> {"Id"->React.string} </th>
      <th> {"Name"->React.string} </th>
      <th> {"Slug"->React.string} </th>
      <th> {"Score (out of 10)"->React.string} </th>
      <th> {"Price per night"->React.string} </th>
      <th> {"Description"->React.string} </th>
      <th> {"City"->React.string} </th>
      <th> {"Added by admin"->React.string} </th>
      <th> {"Created at"->React.string} </th>
    </tr>
    {result.data->Belt.Array.map(el => <HotelTableCard el={el} />)->React.array}
  </table>
}
