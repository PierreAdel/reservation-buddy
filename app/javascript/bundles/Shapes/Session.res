module Session = {
  open Customer
  open Admin

  type user_session = {
    logged_in: bool,
    user: Customer.customer,
  }

  type user_logout = {logged_out: bool}

  type admin_session = {
    logged_in: bool,
    admin: Admin.admin,
  }

  type admin_logout = {logged_out: bool}
}
