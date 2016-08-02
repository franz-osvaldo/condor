class ReceiversController < ApplicationController
  def index
    @receivers  = Receiver.all
    @receiver = Receiver.new
  end
  def show
    @receiver = Receiver.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end
  def edit
    @receiver = Receiver.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end
  def create
    @receiver = Receiver.new(receiver_params)
    respond_to do |format|
      if @receiver.save
        format.js {}
      else
        render :text => 'Algo salio mal'
      end
    end
  end
  def update
    @receiver = Receiver.find(params[:id])
    respond_to do |format|
      if @receiver.update(receiver_params)
        format.js {}
      else
        render :text => 'Algo salio mal'
      end
    end
  end
  def destroy
    @receiver = Receiver.find(params[:id])
    @destroyed = @receiver.destroy
    respond_to do |format|
      format.js{ }
    end
  end
  private
  def receiver_params
    params.require(:receiver).permit(:receiver)
  end
end
