%%raw("import './AdminAuthTemplates.css'")
@react.component
let make = (~title: string, ~secondryTitle: string, ~children: React.element) => {
  <div className={"Container"}>
    <div className={"CenterDiv"}>
      <p
        className={"Text"}
        style={ReactDOM.Style.make(~fontSize="30px", ~fontWeight="600", ~color="#E07751", ())}>
        {title->React.string}
      </p>
      <p
        className={"Text"}
        style={ReactDOM.Style.make(~marginTop="3px", ~fontSize="16px", ~color="grey", ())}>
        {secondryTitle->React.string}
      </p>
      children
    </div>
  </div>
}
