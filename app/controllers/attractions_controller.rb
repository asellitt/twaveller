class AttractionsController < ApplicationController
  before_action :set_attraction, only: [:show, :edit, :update, :destroy]
  before_action :set_area
  before_action :set_trip

  # GET /attractions
  # GET /attractions.json
  def index
    raise User::NotAuthorized unless user_can_view_attraction?

    @attractions = @area.attractions.all
    @banner = BannerPresenter.new(@trip, current_user)
  end

  # GET /attractions/1
  # GET /attractions/1.json
  def show
    raise User::NotAuthorized unless user_can_view_attraction?

    @banner = BannerPresenter.new(@trip, current_user)
    @polaroid = Polaroid::AttractionPresenter.new(@attraction, @area, @trip, full_width: true)
  end

  # GET /attractions/new
  def new
    raise User::NotAuthorized unless user_can_edit_attraction?

    @attraction = Attraction.new(area: @area)
    @banner = BannerPresenter.new(@trip, current_user)
  end

  # GET /attractions/1/edit
  def edit
    raise User::NotAuthorized unless user_can_edit_attraction?

    @banner = BannerPresenter.new(@trip, current_user)
  end

  # POST /attractions
  # POST /attractions.json
  def create
    raise User::NotAuthorized unless user_can_edit_attraction?

    @attraction = @area.attractions.new({area: @area}.merge(attraction_params))

    respond_to do |format|
      if @attraction.save
        format.html { redirect_to [@trip, @area, @attraction], notice: 'Attraction was successfully created.' }
        format.json { render :show, status: :created, location: @attraction }
      else
        format.html { render :new }
        format.json { render json: @attraction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attractions/1
  # PATCH/PUT /attractions/1.json
  def update
    raise User::NotAuthorized unless user_can_edit_attraction?

    respond_to do |format|
      if @attraction.update(attraction_params)
        format.html { redirect_to [@trip, @area, @attraction], notice: 'Attraction was successfully updated.' }
        format.json { render :show, status: :ok, location: @attraction }
      else
        format.html { render :edit }
        format.json { render json: @attraction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attractions/1
  # DELETE /attractions/1.json
  def destroy
    raise User::NotAuthorized unless user_can_edit_attraction?

    @attraction.destroy
    respond_to do |format|
      format.html { redirect_to trip_area_path(@trip, @area), notice: 'Attraction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_attraction
    @attraction = Attraction.find(params[:id])
  end

  def set_area
    @area = Area.find(params[:area_id])
  end

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def attraction_params
    params.
      require(:attraction).
      permit(:area_id, :name, :description, :cost, :image, :link).
      tap do |params|
        params[:cost] = BigDecimal.new(params[:cost])
      end
  end

  def user_can_edit_attraction?
    current_user.present? && TripRight.user_can_edit?(user_id: current_user.id, trip_id: @trip.id)
  end

  def user_can_view_attraction?
    current_user.present? && TripRight.user_can_view?(user_id: current_user.id, trip_id: @trip.id)
  end

end
