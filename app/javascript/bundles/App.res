@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  let client = ReactQuery.Provider.createClient()
  <ReactQuery.Provider client>
    {switch url.path {
    | list{} => <Home />
    | list{"login"} => <UserGuard> <Login /> </UserGuard>
    | list{"register"} => <Register />
    | list{"admin_login"} => <AdminLogin />

    | list{"admin"} => <AdminPage />
    | _ => <div> {"as"->React.string} </div>
    }}
  </ReactQuery.Provider>
  // let total = Counter.add(2,3) -> Belt.Int.toString
  //   <>
  //   <h1>{("Hello Worsld" ++ total)->React.string}</h1>
  //   // <Counter/>
  //   <Zoo/>
  // </>
}
