class OutgoingMovementsController < ApplicationController
  def new_field
    @product = ProductQuantity.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end
  def get_products
    respond_to do |format|
      format.json{render :json => ProductQuantity.all.to_json(:only=>[:id, :description, :quantity, :expiration_date])}
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
    @outgoing_movement = OutgoingMovement.create(outgoing_movement_params)
    params[:outgoing_details].each do |my_params|
      @outgoing_movement.outgoing_details.create(outgoing_detail_params(my_params))
    end
    respond_to do |format|
      format.js{}
      format.html{ redirect_to outgoing_movements_path}
    end
  end
  private
  def outgoing_movement_params
    params.require(:outgoing_movement).permit(:outgoing_movement_type_id, :receiver_id)
  end

  def outgoing_detail_params(my_params)
    my_params.permit(:quantity, :expiration_date, :product_id)
  end
end


