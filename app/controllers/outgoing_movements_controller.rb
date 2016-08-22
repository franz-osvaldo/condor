class OutgoingMovementsController < ApplicationController
  def new_field
    @product_quantity = ProductQuantity.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end
  def get_products
    respond_to do |format|
      format.json{render :json => ProductQuantity.where('quantity > ?',0).to_json(:only=>[:id, :part_number, :description, :serial_number, :quantity, :expiration_date])}
    end
  end

  def index
    @outgoing_movements = OutgoingMovement.all
    @outgoing_movement = OutgoingMovement.new
    flash.now[:products] = 'in'
  end

  def show
    @outgoing_movement = OutgoingMovement.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def create
    @invalids = []
    @index = []
    @outgoing_movement = OutgoingMovement.new(outgoing_movement_params)
    params[:outgoing_details].each_with_index  do |my_params, index|
      outgoing_detail = @outgoing_movement.outgoing_details.build(outgoing_detail_params(my_params))
      @invalids.push(outgoing_detail) unless outgoing_detail.valid?
      @index.push(index) unless outgoing_detail.valid?
    end
    respond_to do |format|
      if @outgoing_movement.save
        format.js{}
      else
        format.js{ render 'errors_messages' }
      end
    end
  end
  private
  def outgoing_movement_params
    params.require(:outgoing_movement).permit(:outgoing_movement_type_id, :receiver_id)
  end

  def outgoing_detail_params(my_params)
    my_params.permit(:quantity, :product_id, :product_quantity_id)
  end
end


