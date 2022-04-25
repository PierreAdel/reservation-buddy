@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  let client = ReactQuery.Provider.createClient()
  <ReactQuery.Provider client>

 { switch url.path {
  | list{} => <Home />
  | list{"login"} => <Login />
  | list{"register"} => <Register />
  | list{"admin_login"} => <AdminLogin />
  | list{"test"} =>   <Test />  
  | list{"test2"} =>   <Test2 />  
  | list{"admin"} =>   <Admin />  
  | _ => <h1>{"404"->React.string} </h1>
  }}
  </ReactQuery.Provider>

  // let total = Counter.add(2,3) -> Belt.Int.toString
  //   <>
  //   <h1>{("Hello Worsld" ++ total)->React.string}</h1>
  //   // <Counter/>
  //   <Zoo/>
  // </>
}
