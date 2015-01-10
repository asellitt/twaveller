class TripRightForm

  delegate :id, :trip_id, :user_id, :permission, to: :trip_right

  def initialize(trip_right = nil)
    @trip_right = trip_right
  end

  def users
    Hash[*users_without_rights.collect{ |user| [user.email, user.id] }.flatten]
  end

  def permissions
    { viewer: :viewer, collaborator: :collaborator }
  end

private

  attr_reader :trip_right

  def users_without_rights
    User.where.not(id: ids_of_users_with_permissions)
  end

  def ids_of_users_with_permissions
    TripRight.where(trip_id: trip_right.trip_id).pluck(:user_id)
  end

end
