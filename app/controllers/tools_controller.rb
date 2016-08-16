class ToolsController < ApplicationController
  helper_method :sort_column, :sort_direction
  def index
    @tool = Tool.new
    @tools = Tool.order(sort_column+' '+sort_direction)
    flash.now[:tools] = 'in'
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
        format.html{ redirect_to tools_path }
      else
        render :text => 'Algo salio mal!'
      end
    end
  end

  def update
    @tool = Tool.find(params[:id])
    # Si no se a enviado la imagen debido a que se a eliminado
    if !params.has_key?(:image) && params[:eliminado] == 'si'
      @tool.image = nil
    end
    respond_to do |format|
      if @tool.update(tool_params)
        format.html{ redirect_to tools_path }
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
    params.require(:tool).permit(:part_number, :description, :specification, :image)
  end

  def sort_column
    Tool.column_names.include?(params[:sort]) ? params[:sort] : 'part_number'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end


