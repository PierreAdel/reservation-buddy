open Hotel
open HotelsHooks
@react.component
let make = (~el: Hotel.hotel) => {
  let (show, setShow) = React.useState(_ => true)

  {
    show
      ? <tr key={el.id->Belt.Int.toString}>
          <td
            style={ReactDOM.Style.make(~textDecoration="underline", ~cursor="pointer", ())}
            onClick={_ => HotelsHooks.useHandleDeleteHotel(el.slug, setShow)}>
            {"Delete"->React.string}
          </td>
          <td> {el.id->Belt.Int.toString->React.string} </td>
          <td> {el.name->React.string} </td>
          <td> {el.slug->React.string} </td>
          <td> {el.score->Belt.Float.toString->React.string} </td>
          <td> {el.price_per_night->Belt.Float.toString->React.string} </td>
          <td> {el.description->React.string} </td>
          <td> {el.city->React.string} </td>
          <td> {el.admin_name->React.string} </td>
          // <td> {el.created_at->Js.Date.fromString->Js.Date.toDateString->React.string} </td>
        </tr>
      : React.null
  }
}
