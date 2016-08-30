class TbosController < ApplicationController

  def get_parts
    # @parts = Fleet.find(params[:id]).parts
    @aircraft = Aircraft.find(params[:id])
    @parts = Part.joins(component: [{system: :aircraft}]).where('aircrafts.id' => params[:id])
    @tbos = Tbo.joins(part: [{component: [{system: :aircraft}]}]).where('aircrafts.id' => params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def index
    @tbo = Tbo.new
    @aircrafts = Aircraft.all
    flash[:aircrafts] = 'in'
  end

  def show
    @tbo =  Tbo.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def edit
    # render :text => params.inspect
    @tbo = Tbo.find(params[:id])
    @parts = Part.joins(component: [{system: :aircraft}]).where('aircrafts.id' => params[:aircraft_id])
    @aircraft = Aircraft.find(params[:aircraft_id])
    respond_to do |format|
      format.js{}
    end
  end

  def create
    # render :text => params.inspect
    @tbo = Tbo.new(tbo_params)
    @aircraft = Aircraft.find(params[:aircraft][:id])
    respond_to do |format|
      if @tbo.save
        format.js{}
      else

      end
    end
  end

  def update
    # render :text => params.inspect
    @tbo = Tbo.find(params[:id])
    @aircraft = Aircraft.find(params[:aircraft][:id])
    respond_to do |format|
      if @tbo.update(tbo_params)
        format.js{}
      else

      end
    end
  end

  def destroy
    @tbo = Tbo.find(params[:id])
    @destroyed = @tbo.destroy
    respond_to do |format|
      format.js{}
    end
  end
  private
  def tbo_params
    params.require(:tbo).permit(:part_id, :condition_id, :unit_id, :time_limit, :over_the_time_limit)
  end
end
