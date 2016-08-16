class FleetsController < ApplicationController
  def aircrafts
    @aircrafts  = Fleet.all
    flash.now[:flights] = 'in'
  end

  def index
    @fleet = Fleet.new
    @aircrafts = Aircraft.all
    @fleets = Fleet.all
    flash.now[:fleet] = 'in'
  end

  def show
    @fleet = Fleet.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def edit
    @aircrafts = Aircraft.all
    @fleet = Fleet.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end
  def create
    # render :text => params.inspect
    @fleet = Fleet.new(fleet_params)
    respond_to do |format|
      if @fleet.save
        format.js{}
      else
      end
    end
  end

  def update
    @fleet = Fleet.find(params[:id])
    respond_to do |format|
      if @fleet.update(fleet_params)
        format.js{}
      else
      end
    end
  end

  def destroy
    @fleet = Fleet.find(params[:id])
    @fleet_destroyed = @fleet.destroy
    respond_to do |format|
      format.js{}
    end
  end
  private
  def fleet_params
    params.require(:fleet).permit(:aircraft_id, :name, :aircraft_registration)
  end
end
