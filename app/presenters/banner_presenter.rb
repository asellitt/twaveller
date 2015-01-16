class BannerPresenter

  delegate :banner_image, :name, to: :trip

  def initialize(trip, current_user_id, options = {})
    @trip = trip
    @current_user_id = current_user_id
    @show_controls = options[:show_controls]
  end

  def start_date
    @start_date ||= trip.start_date.strftime('%e %B %Y')
  end

  def end_date
    @end_date ||= trip.end_date.strftime('%e %B %Y')
  end

  def controls_visibility_class
    show_controls ? '' : 'hidden'
  end

  def editable?
    @editable ||= TripRight.user_can_edit?(user_id: current_user_id, trip_id: trip.id)
  end

  def viewable?
    @viewable ||= TripRight.user_can_view?(user_id: current_user_id, trip_id: trip.id)
  end

  def view_path
    @view_path ||= router.trip_path(trip)
  end

  def edit_path
    @edit_path ||= router.edit_trip_path(trip)
  end

private

  attr_reader :trip, :current_user_id, :show_controls

  def router
    Rails.application.routes.url_helpers
  end

end
