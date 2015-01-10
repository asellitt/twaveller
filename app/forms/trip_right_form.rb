class TripRightForm

  delegate :id, :trip_id, :user_id, :permission, to: :trip_right

  def initialize(trip_right = nil)
    @trip_right = trip_right
  end

  def users
    Hash[*User.all.collect{ |user| [user.email, user.id] }.flatten]
  end

  def permissions
    { viewer: :viewer, collaborator: :collaborator }
  end

private

  attr_reader :trip_right

end
