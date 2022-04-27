open Hotel
@react.component
let make = (~el: Hotel.hotel) => {
  let (show, setShow) = React.useState(_ => true)
  let handleDelete = slug => {
    let x =
      Fetch.fetchWithInit(
        `/api/v1/hotels/${slug}`,
        Fetch.RequestInit.make(
          ~method_=Delete,
          ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
          (),
        ),
      )->Js.Promise.then_(Fetch.Response.json, _)
    setShow(_ => false)
    // RescriptReactRouter.replace("/admin?table=hotels")
  }
  {
    show
      ? <tr key={el.id->Belt.Int.toString}>
          <td
            style={ReactDOM.Style.make(~textDecoration="underline", ~cursor="pointer", ())}
            onClick={_ => handleDelete(el.slug)}>
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
          <td> {el.created_at->Js.Date.fromString->Js.Date.toDateString->React.string} </td>
        </tr>
      : React.null
  }
}
