class CarsController < ApplicationController

  def index
    if session[:user_type] == 'admin'
      @cars =  Car.all
    else
       @cars = Car.where(:status => "A")

    end

    @cars = @cars.search(params[:search])
  end

  def show
    @car = Car.find(params[:id])
  end
  def create
    @car = Car.new(car_params)
    if @car.save
      redirect_to @car
    else
      render plain: params[:cars]
    end
  end
  def new
  end



  def edit

  end

  def update

  end
  private
  def car_params
    params.require(:cars).permit(:manufacturer, :model, :license_number, :status, :style, :rate,:location, :search)

  end
end
