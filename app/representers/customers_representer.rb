class CustomersRepresenter
  def initialize(customers)
    @customers = customers
  end
  def as_json
    customers.map do |customer|
      {
        id: customer.id,
        name: customer.name,
        email: customer.email,
        reservations:
          ReservationsRepresenter.new(customer.reservations).as_json,
      }
    end
  end

  private

  attr_reader :customers
end
