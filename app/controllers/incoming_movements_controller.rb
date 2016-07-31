class IncomingMovementsController < ApplicationController
  def new_field
    @product = Product.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end
  def index
    @incoming_movements = IncomingMovement.all
    @incoming_movement = IncomingMovement.new
  end

  def create
    render :text => params.inspect
  end


end

