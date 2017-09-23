class CarController < ApplicationController

  def show

  end
  def index

  end

  def new

  end

  def create
  @car = Car.new(car_params)

    if @car.save
      redirect @car
    else
      render plain: params[:car]
    end

  end

  private
  def car_params
    params.require(:@car).permit(:manufacturer, :model_name, :license_number)
  end
end
