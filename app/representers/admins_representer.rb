class AdminsRepresenter
  def initialize(admins)
    @admins = admins
  end
  def as_json
    admins.map do |admin|
      { id: admin.id, name: admin.name, email: admin.email }
    end
  end

  private

  attr_reader :admins
end
