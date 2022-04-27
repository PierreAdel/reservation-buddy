class AdminRepresenter
  def initialize(admin)
    @admin = admin
  end
  def as_json
    { id: admin.id, name: admin.name, email: admin.email }
  end

  private

  attr_reader :admin
end
