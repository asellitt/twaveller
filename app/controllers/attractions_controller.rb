class AttractionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_attraction, only: [:show, :edit, :update, :destroy]
  before_action :set_area
  before_action :set_trip

  # GET /attractions
  # GET /attractions.json
  def index
    @attractions = @area.attractions.all
  end

  # GET /attractions/1
  # GET /attractions/1.json
  def show
  end

  # GET /attractions/new
  def new
    @attraction = Attraction.new
  end

  # GET /attractions/1/edit
  def edit
  end

  # POST /attractions
  # POST /attractions.json
  def create
    @attraction = @area.attractions.new(converted_attraction_params)

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
    respond_to do |format|
      if @attraction.update(converted_attraction_params)
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
    @attraction.destroy
    respond_to do |format|
      format.html { redirect_to trip_area_attractions_path(@trip, @area), notice: 'Attraction was successfully destroyed.' }
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
    params.require(:attraction).permit(:area_id, :name, :description, :cost, :image, :link)
  end

  # what the fuck hack
  def converted_attraction_params
    attraction_params.tap do |params|
      params[:cost] = Money.new( (params[:cost].to_f * 100).to_i )
    end
  end

end
