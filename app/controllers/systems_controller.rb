class SystemsController < ApplicationController
  def index
    # render :text => params.inspect
    @aircraft = Aircraft.find(params[:aircraft_id])
    @systems = @aircraft.systems
    @system = System.new
  end

  def show
    @system = System.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def edit
    # render :text => params.inspect
    @system = System.find(params[:id])
    respond_to do |format|
      format.js{ }
    end
  end

  def create
    # render :text => params.inspect
    @aircraft = Aircraft.find(params[:aircraft_id])
    @system = System.new(system_params)
    @system.aircraft = @aircraft
    respond_to do |format|
      if @system.save
        format.js{}
      else
      end
    end
  end

  def update
    # render :text => params.inspect
    @system = System.find(params[:id])
    respond_to do |format|
      if @system.update(system_params)
        format.js{}
      else
      end
    end
  end

  def destroy
    @system = System.find(params[:id])
    @system_destroyed = @system.destroy
    respond_to do |format|
      format.js{}
    end
  end

  private
  def system_params
    params.require(:system).permit(:chapter_number, :title)
  end
end
