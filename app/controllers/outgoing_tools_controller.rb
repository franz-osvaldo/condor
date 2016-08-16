class OutgoingToolsController < ApplicationController
  def get_outgoing_tools
    respond_to do |format|
      format.json{ render :json => ToolQuantity.where('quantity_available > ? AND asset = ?', 0, true).joins(:tool).to_json(only: [:id, :tool_id, :serial_number],
                                                                                                        include: {tool: {only: [:description, :part_number]}}) }
    end
  end

  def get_outgoing_tool_field
    @tool_quantity = ToolQuantity.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end
  def index
    @outgoing_tool = OutgoingTool.new
    @outgoing_tools = OutgoingTool.all
    flash.now[:tools] = 'in'
  end

  def show
    @outgoing_tool = OutgoingTool.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def create
    # render :text => params.inspect
    @outgoing_tool = OutgoingTool.create(outgoing_tool_params)
    params[:outgoing_quantity].each do |my_params|
      @outgoing_tool.outgoing_quantities.create(outgoing_quantity_params(my_params))
    end
    respond_to do |format|
      format.js{}
      format.html{ redirect_to outgoing_tools_path}
    end
  end
  private
  def outgoing_tool_params
    params.require(:outgoing_tool).permit(:outgoing_tool_type_id)
  end

  def outgoing_quantity_params(my_params)
    my_params.permit(:serial_number, :tool_id, :tool_quantity_id)
  end
end
