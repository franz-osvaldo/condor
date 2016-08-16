class ReturnedToolsController < ApplicationController
  def get_borrowed_tools
    @user = User.find(params[:id])
    @array_ids = ToolQuantity.where('user_id = ? AND quantity_available = ?', @user.id, 0).ids
    respond_to do |format|
      format.js{}
    end
  end
  def index
    @returned_tool = ReturnedTool.new
    @returned_tools = ReturnedTool.all
    flash.now[:tools] = 'in'
  end

  def show
    @returned_tool = ReturnedTool.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end
  def create
    @returned_tool = ReturnedTool.create(returned_tool_params)
    params[:returned_quantity].each do |my_params|
      @returned_tool.returned_quantities.create(returned_quantity_params(my_params))
    end
    redirect_to returned_tools_path
  end
  private
  def returned_tool_params
    params.require(:returned_tool).permit(:user_id)
  end

  def returned_quantity_params(my_params)
    my_params.permit(:tool_quantity_id, :serial_number)
  end
end
