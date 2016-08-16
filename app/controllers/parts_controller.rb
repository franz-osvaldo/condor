class PartsController < ApplicationController
  def index
    @component = Component.find(params[:component_id])
    @parts = @component.parts
    @part = Part.new
    flash.now[:aircrafts] = 'in'
  end

  def show
    @part = Part.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def edit
    @part = Part.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def create
    @component = Component.find(params[:component_id])
    @part = Part.new(part_params)
    @part.component = @component
    respond_to do |format|
      if @part.save
        format.js{}
      else
      end
    end
  end
  def update
    @part = Part.find(params[:id])
    respond_to do |format|
      if @part.update(part_params)
        format.js{}
      else
      end
    end
  end
  def destroy
    @part = Part.find(params[:id])
    @part_destroyed = @part.destroy
    respond_to do |format|
      format.js{}
    end
  end

  private
  def part_params
    params.require(:part).permit(:description, :part_number)
  end
end
