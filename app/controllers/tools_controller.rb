class ToolsController < ApplicationController
  helper_method :sort_column, :sort_direction
  def index
    @tool = Tool.new
    @tools = Tool.order(sort_column+' '+sort_direction)
  end

  def show
    @tool = Tool.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def edit
    @tool = Tool.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end


  def create
    @tool = Tool.new(tool_params)
    respond_to do |format|
      if @tool.save
        format.js{}
      else
        render :text => 'Algo salio mal!'
      end
    end
  end

  def update
    @tool = Tool.find(params[:id])
    respond_to do |format|
      if @tool.update(tool_params)
        format.js{}
      else
        render :text => 'Algo salio mal'
      end
    end
  end

  def destroy
    @tool = Tool.find(params[:id])
    @destroyed = @tool.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def tool_params
    params.require(:tool).permit(:part_number, :description, :specification,)
  end

  def sort_column
    Tool.column_names.include?(params[:sort]) ? params[:sort] : 'part_number'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end


