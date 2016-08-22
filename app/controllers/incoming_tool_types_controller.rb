class IncomingToolTypesController < ApplicationController
  def index
    @movement_type = IncomingToolType.new
    @movement_types = IncomingToolType.all
    flash.now[:tools] = 'in'
  end

  def show
    @movement_type = IncomingToolType.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def edit
    @movement_type = IncomingToolType.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def create
    @movement_type = IncomingToolType.new(incoming_tool_type_params)
    respond_to do |format|
      if @movement_type.save
        format.js{}
      else
        format.js{ render 'errors_messages' }
      end
    end
  end

  def update
    @movement_type = IncomingToolType.find(params[:id])
    respond_to do |format|
      if @movement_type.update(incoming_tool_type_params)
        format.js {}
      else
        format.js{ render 'errors_messages' }
      end
    end
  end

  def destroy
    @movement_type = IncomingToolType.find(params[:id])
    @destroyed = @movement_type.destroy
    respond_to do |format|
      format.js
    end
  end
  private
  def incoming_tool_type_params
    params.require(:incoming_tool_type).permit(:movement_type)
  end
end
