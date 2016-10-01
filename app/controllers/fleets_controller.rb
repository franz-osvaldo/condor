class FleetsController < ApplicationController

  def life_time_limits
    @fleets = Fleet.all
    flash.now[:tasks] = 'in'
  end

  def alert_life_limits
    @fleet = Fleet.find(params[:id])
    @alert_life_limits = @fleet.find_out_alert_life_limits
    respond_to do |format|
      format.js{}
    end
  end

  def after_change_item
    @alert_life_limit = AlertLifeLimit.find(params[:id])
    @alert_life_limit.update_state('accomplished')
    TimeDetail.after_change_item('new', @alert_life_limit.fleet.id, @alert_life_limit.life_time_limit.part.id)
    respond_to do |format|
      format.js{}
    end
  end

  def fluids
    @fleets = Fleet.all
    flash.now[:tasks] = 'in'
  end

  def alert_fluids
    @fleet = Fleet.find(params[:id])
    @alert_fluids = @fleet.find_out_alert_fluids
    respond_to do |format|
      format.js{}
    end
  end

  def after_change_fluid
    # render :text => params.inspect
    @alert_fluid = AlertFluid.find(params[:id])
    @alert_fluid.update_attribute(:state,'accomplished')
    respond_to do |format|
      format.js{}
    end
  end

  def tbos
    @fleets = Fleet.all
    flash.now[:tasks] = 'in'
  end

  def get_tbos
    @fleet = Fleet.find(params[:id])
    @alert_tbos = @fleet.alert_tbos.where('state != ?', 'accomplished')
    respond_to do |format|
      format.js{}
    end
  end

  def after_tbo
    part_id = Tbo.find(params[:tbo_id]).part.id
    TimeDetail.after_tbo(params[:option], params[:fleet_id], part_id)
    AlertTbo.find(params[:id]).update(state: 'accomplished')
    @alert_tbo = AlertTbo.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end
  def aircrafts
    @aircrafts  = Fleet.all
    flash.now[:flights] = 'in'
  end

  def scheduled_inspections
    @fleets = Fleet.all
    flash.now[:future_inspections] = 'in'
  end

  def get_systems
    @systems = Fleet.find(params[:id]).aircraft.systems
    @units = Unit.all
    respond_to do |format|
      format.js{}
    end
  end



  def get_graph
    total_flight_hours = Fleet.find(params[:fleet][:fleet_id]).total_flight_hours
    system_id = params[:fleet][:system_id].to_i
    unit_name = Unit.find(params[:fleet][:unit_id]).name
    time = params[:fleet][:time].to_i
    @data = []
    ScheduledInspection.inspection_names(system_id, unit_name).each do |inspection_name|
      @data.push({name: inspection_name,data: ScheduledInspection.keep_top_priority(total_flight_hours, total_flight_hours + time, system_id, unit_name).map{|row| [row[4],row[1],row[2]]}.reject{|a| a[0]!=inspection_name}.map{|row|[row[1],row[2]]}})
    end
    respond_to do |format|
      format.js{  }
    end
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
        format.js{}
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
