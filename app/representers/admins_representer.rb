class AdminsRepresenter
  def initialize(admins)
    @admins = admins
  end
  def as_json
    admins.map do |admin|
      {
        id: admin.id,
        name: admin.name,
        email: admin.email,
        created_at: admin.created_at,
      }
    end
  end

  private

  attr_reader :admins
end
