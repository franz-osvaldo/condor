class IncomingMovementTypesController < ApplicationController
  def index
    @incoming_movement_types = IncomingMovementType.all
    @incoming_movement_type = IncomingMovementType.new
  end

  def show
    @incoming_movement_type = IncomingMovementType.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def edit
    @incoming_movement_type = IncomingMovementType.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end
  def create
    @incoming_movement_type = IncomingMovementType.new(incoming_movement_type_params)
    respond_to do |format|
      if @incoming_movement_type.save
        format.js {}
      else
        render :text => 'Algo salio mal'
      end
    end
  end

  def update
    @incoming_movement_type = IncomingMovementType.find(params[:id])
    respond_to do |format|
      if @incoming_movement_type.update(incoming_movement_type_params)
        format.js {}
      else
        render :text => 'Algo salio mal'
      end
    end
  end

  def destroy
    @incoming_movement_type = IncomingMovementType.find(params[:id])
    @destroyed = @incoming_movement_type.destroy
    respond_to do |format|
      format.js{}
    end
  end

  private
  def incoming_movement_type_params
    params.require(:incoming_movement_type).permit(:movement_type)
  end
end

