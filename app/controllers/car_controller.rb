class CarController < ApplicationController

  def index
    @car = Car.all
  end

  def show
    @car = Car.find(params[:id])
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
    params.require(:car).permit(:manufacturer, :model_name, :license_number)
  end
end
