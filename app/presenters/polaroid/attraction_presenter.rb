class Polaroid::AttractionPresenter

  delegate :image, :name, :description, :cost, to: :attraction

  def initialize(attraction, area, trip)
    @attraction = attraction
    @area = area
    @trip = trip
  end

  def view_path
    router.trip_area_attraction_path(trip, area, attraction)
  end

private

  attr_reader :attraction, :area, :trip

  def router
    Rails.application.routes.url_helpers
  end

end
