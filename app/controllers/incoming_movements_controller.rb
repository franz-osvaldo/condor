class IncomingMovementsController < ApplicationController
  def new_field
    @product = Product.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end
  def get_products
    respond_to do |format|
      format.json{render :json => Product.all.to_json(:only=>[:id, :part_number, :description])}
    end
  end
  def index
    @incoming_movements = IncomingMovement.all
    @incoming_movement = IncomingMovement.new
    flash.now[:products] = 'in'
  end

  def show
    @incoming_movement = IncomingMovement.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def create
    @invalids = []
    @index = []
    @incoming_movement = IncomingMovement.new(incoming_movement_params)
    params[:incoming_details].each_with_index do |my_params, index|
      incoming_detail = @incoming_movement.incoming_details.build(incoming_detail_params(my_params))
      @invalids.push(incoming_detail) unless incoming_detail.valid?
      @index.push(index) unless incoming_detail.valid?
    end
    respond_to do |format|
      if @incoming_movement.save
        format.js{}
      else
        format.js{ render 'same_location.js.erb'}
      end
    end
  end
  private
  def incoming_movement_params
    params.require(:incoming_movement).permit(:incoming_movement_type_id, :supplier_id)
  end
  def incoming_detail_params(my_params)
    my_params.permit(:quantity, :expiration_date, :product_id, :serial_number, :aisle, :section, :level, :position)
  end
end

