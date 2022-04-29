open Customer
open Endpoints
module Fetch = {
  type response

  @send external json: response => Js.Promise.t<'a> = "json"
  @val external fetch: string => Js.Promise.t<response> = "fetch"
}

module CustomersHooks = {
  let useGetCustomersHook = (search, page, limit, sort) => {
    let fetchCustomers = (_): Js.Promise.t<Customer.customers> => {
      Fetch.fetch(
        `${Endpoints.customersEndpoint}?search=${search}&page=${page->Belt.Int.toString}&limit=${limit->Belt.Int.toString}&sort=${sort}`,
      )->Promise.then(Fetch.json)
    }
    ReactQuery.useQuery(
      ReactQuery.queryOptions(
        ~queryFn=fetchCustomers,
        ~queryKey=`${search}-${page->Belt.Int.toString}-${limit->Belt.Int.toString}-${sort}-customers`,
        ~refetchOnWindowFocus=ReactQuery.refetchOnWindowFocus(#bool(true)),
        (),
      ),
    )
  }
}
