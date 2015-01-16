class Polaroid::AttractionPresenter

  delegate :image, :name, :description, to: :attraction

  def initialize(attraction, area, trip, options = {})
    @attraction = attraction
    @area = area
    @trip = trip
    @full_width = options[:full_width]
  end

  def cost
    @cost ||= attraction.cost.format
  end

  def view_path
    router.trip_area_attraction_path(trip, area, attraction)
  end

  def column_class
    full_width ? 'col-md-12' : 'col-md-4'
  end

private

  attr_reader :attraction, :area, :trip, :full_width

  def router
    Rails.application.routes.url_helpers
  end

end
