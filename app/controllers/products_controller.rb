class ProductsController < ApplicationController
  helper_method :sort_column, :sort_direction
  def index
    @products = Product.order(sort_column+' '+sort_direction)
    @product = Product.new
    flash.now[:products] = 'in'
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
    # render :text => params.inspect
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.html{ redirect_to products_path}
      else
        render :text => 'Algo salio mal!'
      end
    end
  end

  def update
    # render :text => params.inspect
    @product = Product.find(params[:id])
    # Si no se a enviado la imagen debido a que se a eliminado
    if !params.has_key?(:image_product) && params[:eliminado] == 'si'
      @product.image_product = nil
    end
    respond_to do |format|
      if @product.update(product_params)
        format.html{ redirect_to products_path }
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
                                    :optimum,
                                    :image_product)
  end
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
  def sort_column
    Product.column_names.include?(params[:sort]) ? params[:sort] : 'part_number'
  end
end
