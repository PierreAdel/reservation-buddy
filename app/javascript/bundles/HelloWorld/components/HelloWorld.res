@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  let client = ReactQuery.Provider.createClient()
  <ReactQuery.Provider client>
    {switch url.path {
    | list{} => <Home />
    | list{"login"} => <UserGuard> <AdminGuard> <Login /> </AdminGuard> </UserGuard>
    | list{"register"} => <UserGuard> <AdminGuard> <Register /> </AdminGuard> </UserGuard>
    | list{"admin_login"} => <UserGuard> <AdminGuard> <AdminLogin /> </AdminGuard> </UserGuard>
    // | list{"test"} => <Test />
    // | list{"test2"} => <Test2 />
    | list{"admin"} => <AllowAdminGuard> <AdminPage /> </AllowAdminGuard>
    | _ => <>
        <h2 style={ReactDOM.Style.make(~margin="30px", ())}>
          {"404: Page not found"->React.string}
        </h2>
      </>
    }}
  </ReactQuery.Provider>

  // let total = Counter.add(2,3) -> Belt.Int.toString
  //   <>
  //   <h1>{("Hello Worsld" ++ total)->React.string}</h1>
  //   // <Counter/>
  //   <Zoo/>
  // </>
}
