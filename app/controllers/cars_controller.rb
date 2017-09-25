class CarsController < ApplicationController

  def index
    @cars = Car.search(params[:search])
  end

  def show
    @car = Car.find(params[:id])
  end

  def new
  end

  def create
  @car = Car.new(car_params)

  if @car.save
      redirect_to @car
    else
      render plain: params[:cars]
  end
  end

  private
  def car_params
    params.require(:cars).permit(:manufacturer, :model, :license_number, :status, :style, :search)
  end
end
