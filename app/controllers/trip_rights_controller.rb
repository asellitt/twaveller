class TripRightsController < ApplicationController
  before_action :set_trip_right, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @trip_rights = TripRight.all
    respond_with(@trip_rights)
  end

  def show
    respond_with(@trip_right)
  end

  def new
    @trip_right = TripRight.new
    respond_with(@trip_right)
  end

  def edit
  end

  def create
    @trip_right = TripRight.new(trip_right_params)
    @trip_right.save
    respond_with(@trip_right)
  end

  def update
    @trip_right.update(trip_right_params)
    respond_with(@trip_right)
  end

  def destroy
    @trip_right.destroy
    respond_with(@trip_right)
  end

  private
    def set_trip_right
      @trip_right = TripRight.find(params[:id])
    end

    def trip_right_params
      params.require(:trip_right).permit(:trip_id, :user_id, :permission)
    end
end
