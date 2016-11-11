class OccupationsController < ApplicationController

  def index
    @occupations = Occupation.all
    @occupation = Occupation.new
    flash.now[:users] = 'in'
  end

  def show
    @occupation = Occupation.find(params[:id])
    respond_to do |format|
      format.js{}
    end
  end

  def edit
    @occupation = Occupation.find(params[:id])
    respond_to do |format|
      format.js{ }
    end
  end
  def create
    @occupation = Occupation.new(occupation_params)
    respond_to do |format|
      if @occupation.save
        format.js{}
      else
        format.js{ render 'errors_messages'}
      end
    end
  end

  def update
    @occupation = Occupation.find(params[:id])
    respond_to do |format|
      if @occupation.update(occupation_params)
        format.js{ }
      else
        format.js{ render 'errors_messages'}
      end
    end
  end

  def destroy
    @occupation = Occupation.find(params[:id])
    @destroyed = @occupation.destroy
    respond_to do |format|
      format.js{}
    end
  end
  private
  def occupation_params
    params.require(:occupation).permit(:name)
  end



end
