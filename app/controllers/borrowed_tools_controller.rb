class BorrowedToolsController < ApplicationController
  def get_tools
    respond_to do |format|
      format.json{ render :json => ToolQuantity.where('quantity_available = ? AND asset = ?', 1, true).joins(:tool).to_json(only: [:id, :serial_number],include: {tool: {only: [:description, :part_number]}} )}
    end
  end

  def new_field
    @tool_quantity = ToolQuantity.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end
  def index
    @borrowed_tool = BorrowedTool.new
    @borrowed_tools = BorrowedTool.all
    flash.now[:tools] = 'in'
  end

  def show
    @borrowed_tool = BorrowedTool.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def create
    # render :text => params.inspect
    @borrowed_tool = BorrowedTool.create(borrowed_tool_params)
    params[:borrowed_quantity].each do |data|
      @borrowed_tool.borrowed_quantities.create(borrowed_quantity_params(data))
    end
    redirect_to borrowed_tools_path
  end
  private
  def borrowed_tool_params
    params.require(:borrowed_tool).permit(:user_id)
  end

  def borrowed_quantity_params(my_params)
    my_params.permit(:serial_number, :expiration_date, :tool_quantity_id)
  end
end
