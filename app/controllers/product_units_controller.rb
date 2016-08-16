class ProductUnitsController < ApplicationController
  def index
    @product_units = ProductUnit.all
    @product_unit = ProductUnit.new
    flash.now[:products] = 'in'
  end

  def show
    @product_unit = ProductUnit.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def edit
    @product_unit = ProductUnit.find(params[:id])
    respond_to do |format|
      format.js{ }
    end
  end
  def create
    @product_unit = ProductUnit.new(product_unit_params)
    respond_to do |format|
      if @product_unit.save
        format.js{}
      else
        render :text => 'Algo salio mal'
      end
    end
  end

  def update
    @product_unit = ProductUnit.find(params[:id])
    respond_to do |format|
      if @product_unit.update(product_unit_params)
        format.js{ }
      else
        render :text => 'Algo salio mal'
      end
    end
  end

  def destroy
    @product_unit = ProductUnit.find(params[:id])
    @destroyed = @product_unit.destroy
    respond_to do |format|
      format.js{}
    end
  end
  private
  def product_unit_params
    params.require(:product_unit).permit(:name)
  end
end
