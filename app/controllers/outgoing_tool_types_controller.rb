class OutgoingToolTypesController < ApplicationController
  def index
    @movement_type = OutgoingToolType.new
    @movement_types = OutgoingToolType.all
    flash.now[:tools] = 'in'
  end

  def show
    @movement_type = OutgoingToolType.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def edit
    @movement_type = OutgoingToolType.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def create
    @movement_type = OutgoingToolType.new(outgoing_tool_type_params)
    respond_to do |format|
      if @movement_type.save
        format.js{}
      else
        format.js{ render 'errors_messages' }
      end
    end
  end

  def update
    @movement_type = OutgoingToolType.find(params[:id])
    respond_to do |format|
      if @movement_type.update(outgoing_tool_type_params)
        format.js {}
      else
        format.js{ render 'errors_messages' }
      end
    end
  end

  def destroy
    @movement_type = OutgoingToolType.find(params[:id])
    @destroyed = @movement_type.destroy
    respond_to do |format|
      format.js
    end
  end
  private
  def outgoing_tool_type_params
    params.require(:outgoing_tool_type).permit(:movement_type)
  end
end

