class AreasController < ApplicationController
  before_action :set_area, only: [:show, :edit, :update, :destroy]
  before_action :set_trip

  # GET /areas
  # GET /areas.json
  def index
    raise User::NotAuthorized unless user_can_view_area?

    @areas = @trip.areas.all
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
    raise User::NotAuthorized unless user_can_view_area?

    @presenter = AreaPresenter.new(@area)
  end

  # GET /areas/new
  def new
    raise User::NotAuthorized unless user_can_edit_area?

    @area = Area.new
  end

  # GET /areas/1/edit
  def edit
    raise User::NotAuthorized unless user_can_edit_area?
  end

  # POST /areas
  # POST /areas.json
  def create
    raise User::NotAuthorized unless user_can_edit_area?

    @area = Area.new(area_params.merge(trip_id: @trip.id))

    respond_to do |format|
      if @area.save
        format.html { redirect_to [@trip, @area], notice: 'Area was successfully created.' }
        format.json { render :show, status: :created, location: [@trip, @area] }
      else
        format.html { render :new }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /areas/1
  # PATCH/PUT /areas/1.json
  def update
    raise User::NotAuthorized unless user_can_edit_area?

    respond_to do |format|
      if @area.update(area_params)
        format.html { redirect_to [@trip, @area], notice: 'Area was successfully updated.' }
        format.json { render :show, status: :ok, location: [@trip, @area] }
      else
        format.html { render :edit }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    raise User::NotAuthorized unless user_can_edit_area?

    @area.destroy
    respond_to do |format|
      format.html { redirect_to trip_areas_path(@trip), notice: 'Area was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def set_area
    @area = Area.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def area_params
    params.require(:area).permit(:trip_id, :name, :description, :image, :proposed_date)
  end

  def user_can_edit_area?
    current_user.present? && TripRight.user_can_edit?(user_id: current_user.id, trip_id: @trip.id)
  end

  def user_can_view_area?
    current_user.present? && TripRight.user_can_view?(user_id: current_user.id, trip_id: @trip.id)
  end

end
