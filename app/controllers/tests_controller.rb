class TestsController < ApplicationController
  def index
    @fleets = Fleet.all
  end

  def create_flight
    # render :text => params.inspect
    params[:test][:times].to_i.times{
      Flight.create(fleet_id: params[:test][:fleet_id],
                    departure_date: Date.today,
                    takeoff_time: Time.now ,
                    landing_time: Time.now + params[:test][:flight_time].to_i.hours,
                    departure_time: Time.now,
                    arrival_time: Time.now + params[:test][:flight_time].to_i.hours,
                    origin: 'Beni',
                    destination: 'Pando')
    }
    redirect_to tests_path
  end

  def create_days
    # render :text => params.inspect
    TimeDetail.where('fleet_id = ?', params[:test][:fleet_id]).each do |time_detail|
      time_detail.update_attribute(:dsn, time_detail.dsn + params[:test][:days].to_i)
      time_detail.update_attribute(:dso, time_detail.dso + params[:test][:days].to_i)
    end
    redirect_to tests_path
  end
end

