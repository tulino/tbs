class EventLocationsController < ApplicationController
  before_action :set_event_location, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @event_locations = EventLocation.all
    authorize @event_locations
  end

  def show; end

  def new
    @event_location = EventLocation.new
    authorize @event_location
  end

  def edit; end

  def create
    @event_location = EventLocation.new(event_location_params)
    authorize @event_location
    respond_to do |format|
      if @event_location.save
        format.html { redirect_to @event_location, notice: 'Etkinlik yeri başarıyla oluşturuldu.' }
        format.json { render :show, status: :created, location: @event_location }
      else
        format.html { render :new }
        format.json { render json: @event_location.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @event_location
    respond_to do |format|
      if @event_location.update(event_location_params)
        format.html { redirect_to @event_location, notice: 'Etkinlik yeri başarıyla güncellendi.' }
        format.json { render :show, status: :ok, location: @event_location }
      else
        format.html { render :edit }
        format.json { render json: @event_location.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @event_location
    @event_location.destroy
    respond_to do |format|
      format.html { redirect_to event_locations_url, notice: 'Etkinlik yeri başarıyla silindi.' }
      format.json { head :no_content }
    end
  end

  private

  def set_event_location
    @event_location = EventLocation.find(params[:id])
  end

  def event_location_params
    params.fetch(:event_location, {}).permit(:name)
  end
end
