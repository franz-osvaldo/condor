class FluidsController < ApplicationController
  def get_parts
    @aircraft = Aircraft.find(params[:id])
    @parts = Part.joins(component: [{system: :aircraft}]).where('aircrafts.id' => params[:id])
    @fluids = Fluid.joins(part: [{component: [{system: :aircraft}]}]).where('aircrafts.id' => params[:id])
    respond_to do |format|
      format.js{}
    end
  end
  def index
    @fluid = Fluid.new
    @aircrafts = Aircraft.all
    flash.now[:aircrafts] = 'in'
  end

  def show
    @fluid =  Fluid.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def edit
    # render :text => params.inspect
    @fluid = Fluid.find(params[:id])
    @parts = Part.joins(component: [{system: :aircraft}]).where('aircrafts.id' => params[:aircraft_id])
    @aircraft = Aircraft.find(params[:aircraft_id])
    respond_to do |format|
      format.js{}
    end
  end


  def create
    # render :text => params.inspect
    @fluid = Fluid.new(fluid_params)
    @aircraft = Aircraft.find(params[:aircraft][:id])
    respond_to do |format|
      if @fluid.save
        format.js{}
      else

      end
    end
  end
  def update
    # render :text => params.inspect
    @fluid = Fluid.find(params[:id])
    @aircraft = Aircraft.find(params[:aircraft][:id])
    respond_to do |format|
      if @fluid.update(fluid_params)
        format.js{}
      else

      end
    end
  end

  def destroy
    @fluid = Fluid.find(params[:id])
    @destroyed = @fluid.destroy
    respond_to do |format|
      format.js{}
    end
  end

  private
  def fluid_params
    params.require(:fluid).permit(:part_id, :time_limit, :unit_id, :over_the_time_limit, :alert_before, :condition_id)
  end
end
