class CarsController < ApplicationController

  def index
    if is_admin?
      @cars =  Car.all
    else
       @cars = Car.where(:status => "A")
    end
    @cars = @cars.search(params[:search])
  end

  def show
    @car = Car.find(params[:id])
  end

  def destroy
    Car.destroy(params[:id])
    flash.now[:danger] = "Car has been deleted"
    @cars = index #hacky solution
    redirect_to cars_path
      
end
  def create
    @car = Car.new(car_params)
    if @car.save
      redirect_to @car
    else
     # render plain: params[:cars]
    end
  end
  def new
    if is_customer?
      redirect_to unauthorized_show_path
    end

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

