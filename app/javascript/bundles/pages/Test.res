open HotelsHooks
@react.component
let make = () => {
  let hotelsData = HotelsHooks.useGetHotelsHook("", 1, 100, "")
  let content = switch hotelsData {
  | {isLoading: true} => <> {"Loading..."->React.string} </>
  | {data: Some(result), isLoading: false, isError: false} =>
    result.data->Belt.Array.map(el => <p key={el.name}> {el.name->React.string} </p>)->React.array
  | _ => <> {`Unexpected error...`->React.string} </>
  }
  <div> content </div>
}
