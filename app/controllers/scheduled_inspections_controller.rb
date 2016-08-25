class ScheduledInspectionsController < ApplicationController

  def index
    # render :text => params.inspect
    @system = System.find(params[:system_id])
    @scheduled_inspections = @system.scheduled_inspections
    flash.now[:aircrafts] = 'in'
  end

  def show
    @scheduled_inspection = ScheduledInspection.find(params[:id])
    flash.now[:aircrafts] = 'in'
  end
  def new
    @system = System.find(params[:system_id])
    @scheduled_inspection = ScheduledInspection.new
    10.times do
      @actions = @scheduled_inspection.actions.build
      (5 - @actions.time_limits.count).times do
        @time_limits = @actions.time_limits.build
        @time_limits.build_over_the_time_limit
      end
    end
    flash.now[:aircrafts] = 'in'
  end

  def edit
    @priority_inspections = Inspection.where('name != ?', 'Nuevo')
    @scheduled_inspection = ScheduledInspection.find(params[:id])
    (10 - @scheduled_inspection.actions.count).times do
      @action = @scheduled_inspection.actions.build
    end
    @scheduled_inspection.actions.each do |action|
        (5 - action.time_limits.count).times do
          time_limit = action.time_limits.build
          time_limit.build_over_the_time_limit
        end
    end
    flash.now[:aircrafts] = 'in'
  end

  def create
    # render :text => params.inspect
    @system = System.find(params[:system_id])
    @scheduled_inspection = ScheduledInspection.new(scheduled_inspection_params)
    @scheduled_inspection.system = @system
    if @scheduled_inspection.save
      redirect_to @scheduled_inspection
    else
      render :new
    end
  end

  def update
    @scheduled_inspection = ScheduledInspection.find(params[:id])
    if @scheduled_inspection.update(scheduled_inspection_params)
      redirect_to @scheduled_inspection
    else
     render :text => 'Algo salio terriblemente mal!! :('
    end
  end

  def destroy
    @scheduled_inspection = ScheduledInspection.find(params[:id])
    @destroyed = @scheduled_inspection.destroy
    respond_to do |format|
      format.js {}
    end
  end
  private
  def scheduled_inspection_params
    params.require(:scheduled_inspection).permit(:name,
                                                 :system_id,
                                                 actions_attributes: [:id,
                                                                      :action,
                                                                      task_ids: [],
                                                                      time_limits_attributes: [:id,
                                                                                               :time,
                                                                                               :unit_id,
                                                                                               :inspection_id,
                                                                                               over_the_time_limit_attributes: [:id,
                                                                                                                                :time,
                                                                                                                                :unit_id]]],

                                                 inspection_ids: [])
  end
end
