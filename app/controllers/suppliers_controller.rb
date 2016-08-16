class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all
    @supplier = Supplier.new
    flash.now[:products] = 'in'
  end

  def show
    @supplier = Supplier.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def edit
    @supplier = Supplier.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end
  def create
    @supplier = Supplier.new(supplier_params)
    respond_to do |format|
      if @supplier.save
        format.js {}
      else
        render :text => 'Algo salio mal'
      end
    end
  end

  def update
    @supplier = Supplier.find(params[:id])
    respond_to do |format|
      if @supplier.update(supplier_params)
        format.js {}
      else
        render :text => 'Algo salio mal'
      end
    end
  end

  def destroy
    @supplier = Supplier.find(params[:id])
    @destroyed = @supplier.destroy
    respond_to do |format|
      format.js{ }
    end
  end

  private
  def supplier_params
    params.require(:supplier).permit(:supplier)
  end
end

