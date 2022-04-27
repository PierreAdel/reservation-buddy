class CustomerRepresenter
  def initialize(customer)
    @customer = customer
  end
  def as_json
    {
      id: customer.id,
      name: customer.name,
      email: customer.email,
      created_at: customer.created_at,
      reservations: ReservationsRepresenter.new(customer.reservations).as_json,
    }
  end

  private

  attr_reader :customer
end
