class ProductsController < ApplicationController

  def index
    @products = Product.all
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def edit
    @product = Product.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end
  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.js{}
      else
        render :text => 'Algo salio mal!'
      end
    end
  end

  def update
    @product = Product.find(params[:id])
    respond_to do |format|
      if @product.update(product_params)
        format.js{}
      else
        render :text => 'Algo salio mal'
      end
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @destroyed = @product.destroy
    respond_to do |format|
      format.js
    end
  end
  private
  def product_params
    params.require(:product).permit(:part_number,
                                    :description,
                                    :specification,
                                    :product_unit_id,
                                    :procurement_lead_time,
                                    :maximum,
                                    :minimum,
                                    :optimum)
  end
end
