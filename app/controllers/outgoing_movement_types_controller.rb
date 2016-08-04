class OutgoingMovementTypesController < ApplicationController
  def index
    @outgoing_movement_types = OutgoingMovementType.all
    @outgoing_movement_type = OutgoingMovementType.new
  end

  def show
    @outgoing_movement_type = OutgoingMovementType.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def edit
    @outgoing_movement_type = OutgoingMovementType.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end
  def create
    @outgoing_movement_type = OutgoingMovementType.new(outgoing_movement_type_params)
    respond_to do |format|
      if @outgoing_movement_type.save
        format.js {}
      else
        render :text => 'Algo salio mal'
      end
    end
  end

  def update
    @outgoing_movement_type = OutgoingMovementType.find(params[:id])
    respond_to do |format|
      if @outgoing_movement_type.update(outgoing_movement_type_params)
        format.js {}
      else
        render :text => 'Algo salio mal'
      end
    end
  end

  def destroy
    @outgoing_movement_type = OutgoingMovementType.find(params[:id])
    @destroyed = @outgoing_movement_type.destroy
    respond_to do |format|
      format.js{}
    end
  end

  private
  def outgoing_movement_type_params
    params.require(:outgoing_movement_type).permit(:movement_type)
  end
end
