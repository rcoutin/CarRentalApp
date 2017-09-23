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
<<<<<<< HEAD
  @car = Car.new(params.require(:car).permit(:manufacturer, :model, :license_number))
=======
  @car = Car.new(car_params)
>>>>>>> fb47917380abf6f2aa9b3be7a285fc7dc8133cb5

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
