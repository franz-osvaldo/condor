class IncomingToolsController < ApplicationController
  def get_incoming_tools
    respond_to do |format|
      format.json{ render :json => Tool.all.to_json(:only => [:id, :part_number, :description]) }
    end
  end

  def get_incoming_tool_field
    @tool = Tool.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end
  def index
    @incoming_tool = IncomingTool.new
    @incoming_tools = IncomingTool.all
    flash.now[:tools] = 'in'
  end

  def show
    @incoming_tool = IncomingTool.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def create
    # render :text => params.inspect
    @incoming_tool = IncomingTool.create(incoming_tool_params)
    params[:incoming_quantity].each do |my_params|
      @incoming_tool.incoming_quantities.create(incoming_quantity_params(my_params))
    end
    respond_to do |format|
      format.js{}
    end
  end
  private
  def incoming_tool_params
    params.require(:incoming_tool).permit(:incoming_tool_type_id)
  end

  def incoming_quantity_params(my_params)
    my_params.permit(:serial_number, :tool_id, :aisle, :section, :level, :position)
  end
end

