type input = {
  label: string,
  type_: string,
  value: string,
  required: bool,
}
@react.component
let make = (~clicked) => {
  let input = {
    label: "Name",
    type_: "text",
    value: "",
    required: true,
  }
  let arr = [input, input, input]

  <>
    <div onClick={clicked} className={"Backdrop"} />
    <div className={"GenericForm"}>
      <p className={"GenericFormTitle"}> {"Add User Form"->React.string} </p>
      {arr
      ->Belt.Array.map(el => <>
        <p className={"Label"}> {(el.label ++ " *")->React.string} </p>
        <input
          value={el.value} type_={el.type_} className={"UpperTableInput"} placeholder={el.label}
        />
      </>)
      ->React.array}
      <button className={"GenericFormSubmit"}> {"Submit"->React.string} </button>
    </div>
  </>
}
