class ComponentsController < ApplicationController
  def index
    # render :text => params.inspect
    @system = System.find(params[:system_id])
    @components = @system.components
    @component = Component.new
    flash.now[:aircrafts] = 'in'
  end

  def show
    @component = Component.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def edit
    @component = Component.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end
  def create
    @system = System.find(params[:system_id])
    @component = Component.new(component_params)
    @component.system = @system
    respond_to do |format|
      if @component.save
        format.js{}
      else
      end
    end
  end

  def update
    @component = Component.find(params[:id])
    respond_to do |format|
      if @component.update(component_params)
        format.js{}
      else
      end
    end
  end

  def destroy
    @component = Component.find(params[:id])
    @component_destroyed = @component.destroy
    respond_to do |format|
      format.js{}
    end
  end

  private
  def component_params
    params.require(:component).permit(:name)
  end
end
