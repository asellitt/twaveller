class TripsController < ApplicationController
  skip_before_action :authenticate_user!, only: :first_or_new
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  # GET /trips
  # GET /trips.json
  def index
    @trips = Trip.all.collect { |trip| TripPresenter.new(trip, current_user.id) }
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    raise User::NotAuthorized unless user_can_view_trip?

    @presenter = TripPresenter.new(@trip, current_user)
    @polaroids = @trip.areas.collect { |area| Polaroid::AreaPresenter.new(area, @trip) }
  end

  # GET /trips/new
  def new
    @trip = Trip.new
  end

  # GET /trips/1/edit
  def edit
    raise User::NotAuthorized unless user_can_edit_trip?
  end

  # POST /trips
  # POST /trips.json
  def create
    Trip.transaction do
      @trip = Trip.new(trip_params)
      respond_to do |format|
        if @trip.save
          TripRight.create!(user_id: current_user.id, trip_id: @trip.id, permission: :owner)
          format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
          format.json { render :show, status: :created, location: @trip }
        else
          format.html { render :new }
          format.json { render json: @trip.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
    raise User::NotAuthorized unless user_can_edit_trip?

    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html { render :edit }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    raise User::NotAuthorized unless user_can_edit_trip?

    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_url, notice: 'Trip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_trip
    @trip = Trip.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def trip_params
    params.require(:trip).permit(:name, :banner_image, :start_date, :end_date, :currency_code, :map)
  end

  def user_can_edit_trip?
    current_user.present? && TripRight.user_can_edit?(user_id: current_user.id, trip_id: @trip.id)
  end

  def user_can_view_trip?
    current_user.present? && TripRight.user_can_view?(user_id: current_user.id, trip_id: @trip.id)
  end
end
