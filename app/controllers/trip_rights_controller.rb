class TripRightsController < ApplicationController
  before_action :set_trip_right, only: [:show, :edit, :update, :destroy]
  before_action :set_trip

  respond_to :html

  def index
    @trip_rights = TripRight.all.collect{ |right| TripRightPresenter.new(right) }
  end

  def show
  end

  def new
    @trip_right = TripRight.new(trip_id: @trip.id)
    @form = TripRightForm.new(@trip_right)
  end

  def edit
    @form = TripRightForm.new(@trip_right)
  end

  def create
    @trip_right = TripRight.new(trip_right_params)
    respond_to do |format|
      begin
        trip = Trip.find(@trip_right.trip_id)
        user = User.find(@trip_right.user_id)
        if @trip_right.save
          format.html { redirect_to trip, notice: "#{user.email} is now a #{@trip_right.permission} of #{trip.name}." }
          format.json { render :show, status: :created, location: trip }
        else
          format.html { render :new }
          format.json { render json: @trip_right.errors, status: :unprocessable_entity }
        end
      rescue ActiveRecord::RecordNotUnique => exception
        format.html do
          redirect_to(
            new_trip_trip_right_path(trip_right: { trip_id: trip.id }),
            alert: "#{user.email} is already a #{@trip_right.permission} of #{trip.name}.",
          )
        end
      end
    end
  end

  def update
    @trip_right.update(trip_right_params)
    respond_with(@trip, @trip_right)
  end

  def destroy
    @trip_right.destroy
    respond_with(@trip, @trip_right)
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def set_trip_right
    @trip_right = TripRight.find(params[:id])
  end

  def trip_right_params
    params.require(:trip_right).permit(:trip_id, :user_id, :permission)
  end
end
