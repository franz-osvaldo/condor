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
    @invalids = []
    @index = []
    @incoming_tool = IncomingTool.new(incoming_tool_params)
    params[:incoming_quantity].each_with_index  do |my_params, index|
      incoming_quantity =  @incoming_tool.incoming_quantities.build(incoming_quantity_params(my_params))
      @invalids.push(incoming_quantity) unless incoming_quantity.valid?
      @index.push(index) unless incoming_quantity.valid?
    end
    respond_to do |format|
      if @incoming_tool.save
        format.js{}
      else
        format.js{ render 'errors_messages.js.erb'}
      end
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

