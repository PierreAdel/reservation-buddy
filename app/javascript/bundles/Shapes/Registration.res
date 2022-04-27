module Registration = {
  open Customer

  type registration = {
    logged_in: bool,
    user: Customer.customer,
  }
}
