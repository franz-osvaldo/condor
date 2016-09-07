class LifeTimeLimitsController < ApplicationController

  def get_parts
    @aircraft = Aircraft.find(params[:id])
    @parts = Part.joins(component: [{system: :aircraft}]).where('aircrafts.id' => params[:id])
    @life_time_limits = LifeTimeLimit.joins(part: [{component: [{system: :aircraft}]}]).where('aircrafts.id' => params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def index
    @life_time_limit = LifeTimeLimit.new
    @aircrafts = Aircraft.all
    flash.now[:aircrafts] = 'in'
  end

  def show
    @life_time_limit =  LifeTimeLimit.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def edit
    # render :text => params.inspect
    @life_time_limit = LifeTimeLimit.find(params[:id])
    @parts = Part.joins(component: [{system: :aircraft}]).where('aircrafts.id' => params[:aircraft_id])
    @aircraft = Aircraft.find(params[:aircraft_id])
    respond_to do |format|
      format.js{}
    end
  end

  def create
    @life_time_limit = LifeTimeLimit.new(life_time_limit_params)
    @aircraft = Aircraft.find(params[:aircraft][:id])
    respond_to do |format|
      if @life_time_limit.save
        format.js{}
      else

      end
    end
  end

  def update
    # render :text => params.inspect
    @life_time_limit = LifeTimeLimit.find(params[:id])
    @aircraft = Aircraft.find(params[:aircraft][:id])
    respond_to do |format|
      if @life_time_limit.update(life_time_limit_params)
        format.js{}
      else

      end
    end
  end

  def destroy
    @life_time_limit = LifeTimeLimit.find(params[:id])
    @destroyed = @life_time_limit.destroy
    respond_to do |format|
      format.js{}
    end
  end
  private
  def life_time_limit_params
    params.require(:life_time_limit).permit(:part_id, :unit_id, :life_limit, :alert_before)
  end
end
