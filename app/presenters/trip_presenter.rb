class TripPresenter

  delegate :id, :areas, :map, to: :trip

  def initialize(trip, current_user_id)
    @trip = trip
    @current_user_id = current_user_id
  end

  def start_date
    @start_date ||= trip.start_date.strftime('%e %B %Y')
  end

  def total
    @total ||= trip.total.format
  end

  def area_visibility_class
    'hidden' unless editable?
  end

  def calendar_column_class
    editable? ? 'col-md-9' : 'col-md-12'
  end

private

  attr_reader :trip, :current_user_id

  def editable?
    @editable ||= TripRight.user_can_edit?(user_id: current_user_id, trip_id: trip.id)
  end

end
