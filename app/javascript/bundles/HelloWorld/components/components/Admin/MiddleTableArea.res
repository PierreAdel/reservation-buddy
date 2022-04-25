type user = {
  id: int,
  name: string,
  email: string,
  password: string,
  created_at: string,
  updated_at: string,
}
type catData = {userId: int, id: int, title: string, completed: bool}
module Decode = {
  open Json.Decode
  let catData = (data: Js.Json.t) => {
    userId: field("userId", int, data),
    id: field("id", int, data),
    title: field("title", string, data),
    completed: field("completed", bool, data),
  }
}
@react.component
let make = () => {
  let data3a: catData = {userId: 1, id: 1, title: "hello", completed: false}
  let (breweries, setBreweries) = React.useState(_ => data3a)

  let fetchJson = (url, decoder) =>
    Fetch.fetch(url)
    ->Js.Promise.then_(Fetch.Response.json, _)
    ->Js.Promise.then_(obj => obj->decoder->Js.Promise.resolve, _)

  let fetchCat = () => fetchJson("https://jsonplaceholder.typicode.com/todos/1", Decode.catData)

  let _ = fetchCat()->Js.Promise.then_(data => data.id->Js.log->Js.Promise.resolve, _)
  let url = RescriptReactRouter.useUrl()
  let user = {
    id: 1,
    name: "Pierre Adel",
    email: "pierreadelkamel@gmail.com",
    password: "password1",
    created_at: "12/12/2022",
    updated_at: "12/12/2022",
  }
  let arr = [user, user, user, user, user, user, user, user, user, user]
  <table>
    // <p className="TableTitleText"> {`${url.search} table`->React.string} </p>
    <tr>
      <th> {"Actions"->React.string} </th>
      <th> {"Id"->React.string} </th>
      <th> {"Name"->React.string} </th>
      <th> {"Email"->React.string} </th>
      <th> {"Created at"->React.string} </th>
    </tr>
    {arr
    ->Belt.Array.map(el =>
      <tr key={el.id->Belt.Int.toString}>
        <td> {"Delete"->React.string} </td>
        <td> {el.id->Belt.Int.toString->React.string} </td>
        <td> {el.name->React.string} </td>
        <td> {el.email->React.string} </td>
        <td> {el.created_at->React.string} </td>
      </tr>
    )
    ->React.array}
  </table>
}
