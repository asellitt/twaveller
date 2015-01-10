class TripRightPresenter

  delegate :id, :trip_id, :user_id, :permission, to: :trip_right
  delegate :email, to: :user, prefix: true
  delegate :name, to: :trip, prefix: true

  def initialize(trip_right)
    @trip_right = trip_right
  end

  def view_path
    @view_path ||= router.trip_right_path(trip_right)
  end

  def edit_path
    @edit_path ||= router.edit_trip_right_path(trip_right)
  end

private

  attr_reader :trip_right

  def user
    @user ||= User.find(trip_right.user_id)
  end

  def trip
    @trip ||= Trip.find(trip_right.trip_id)
  end

  def router
    Rails.application.routes.url_helpers
  end

end
