class InspectionsController < ApplicationController

  def index
    @inspection = Inspection.new
    @inspections = Inspection.where('name != ?  AND name != ? ', 'Nuevo', 'No requerido')
    flash.now[:aircrafts] = 'in'
  end

  def show
    @inspection = Inspection.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def edit
    @inspection = Inspection.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def create
    @inspection = Inspection.new(inspection_params)
    respond_to do |format|
      if @inspection.save
        format.js{}
      else
        format.js{ render 'errors_messages' }
      end
    end
  end

  def update
    @inspection = Inspection.find(params[:id])
    respond_to do |format|
      if @inspection.update(inspection_params)
        format.js {}
      else
        format.js{ render 'errors_messages' }
      end
    end
  end

  def destroy
    @inspection = Inspection.find(params[:id])
    @destroyed = @inspection.destroy
    respond_to do |format|
      format.js
    end
  end
  private
  def inspection_params
    params.require(:inspection).permit(:name)
  end
end
