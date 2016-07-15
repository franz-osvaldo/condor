class AircraftsController < ApplicationController
  def index
    @aircraft = Aircraft.new
    @aircrafts = Aircraft.all
  end

  def show
    # render :text => params.inspect
    @aircraft = Aircraft.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def edit
    @aircraft = Aircraft.find(params[:id])
    respond_to do |format|
      format.js{ }
    end
  end

  def create
    @aircraft = Aircraft.new(aircraft_params)
    respond_to do |format|
      if @aircraft.save
        format.js{}
      else
        format.js{}
      end
    end
  end

  def update
    @aircraft = Aircraft.find(params[:id])
    respond_to do |format|
      if @aircraft.update(aircraft_params)
        format.js{}
      else

      end
    end
  end

  def destroy
    @aircraft = Aircraft.find(params[:id])
    @aircraft_destroyed = @aircraft.destroy
    respond_to do |format|
      format.js{}
    end
  end
  private
  def aircraft_params
    params.require(:aircraft).permit(:manufacturer, :trade_name)
  end
end
