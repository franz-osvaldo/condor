class FlightsController < ApplicationController
  def index
    # render :text => params.inspect
    @aircraft = Fleet.find(params[:fleet_id])
    @flights = @aircraft.flights
  end
  def show
    # render :text => params.inspect
    @flight = Flight.find(params[:id])
  end
  def new
    # render :text =>  params.inspect
    @aircraft = Fleet.find(params[:fleet_id])
    @flight = Flight.new
    3.times{@flight.passengers.build}
  end

  def edit
    # render :text => params.inspect
    @flight = Flight.find(params[:id])
    (3 - @flight.passengers.count).times{@flight.passengers.build}
  end
  def create
    # render :text => params.inspect
    @fleet = Fleet.find(params[:fleet_id])
    @flight = Flight.new(flight_params)
    @flight.fleet = @fleet
    respond_to do |format|
      if @flight.save
        format.html{ redirect_to @flight }
      else
        render :text => 'Algo salio  mal!! :('
      end
    end
  end

  def update
    @flight = Flight.find(params[:id])
    respond_to do |format|
      if @flight.update(flight_params)
        format.html{ redirect_to @flight }
      else
        render :text => 'Algo salio mal! :('
      end
    end
  end

  def destroy
    @flight = Flight.find(params[:id])
    @destroyed = @flight.destroy
    respond_to do |format|
      format.js{ }
    end
  end
  private
  def flight_params
    params.require(:flight).permit(:departure_date,
                                   :departure_time,
                                   :arrival_time,
                                   :takeoff_time,
                                   :landing_time,
                                   :origin,
                                   :destination,
                                   passengers_attributes: [:id, :name, :identification_number],
                                   flight_crew_ids: [] )
  end
end
