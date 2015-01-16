class Polaroid::AreaPresenter

  delegate :image, :name, to: :area
  delegate :description, to: :area_presenter

  def initialize(area, trip)
    @area = area
    @trip = trip
  end

  def cost
    area_presenter.total
  end

  def column_class
    'col-md-4'
  end

  def view_path
    router.trip_area_path(trip, area)
  end

private

  attr_reader :area, :trip

  def area_presenter
    @area_presenter = ::AreaPresenter.new(area)
  end

  def router
    Rails.application.routes.url_helpers
  end

end
