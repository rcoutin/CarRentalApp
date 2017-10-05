class CarsController < ApplicationController
  def index

    if is_admin?
      @cars =  Car.all
    elsif is_customer?
    res= Reservation.where(:customer_id => current_user)
    car = []
    res.each{|r| car << r.car_id}
    @cars = Car.where.not(:id => car)

     # @cars = Reservation.joins("RIGHT JOIN 'cars' ON cars.id = reservations.car_id").where.not(:customer_id => current_user).select("cars.*")      
    end
    @cars = @cars.search(params[:search])
    
  end
  def show
    @car = Car.find(params[:id])
    @reservation = Reservation.where(:car_id => params[:id])

    @customer=Customer.new
    @reservation.each{ |r| @customer = Customer.find(r.customer_id) }
    
    if is_admin?
      @reservation_hist = ReservationHistory.where(:car_id => params[:id])
    end
  end
  def destroy
    @reservation = Reservation.where(:car_id => params[:id])
    if @reservation.length == 0
      Car.destroy(params[:id])
      flash.now[:danger] = "Car has been deleted"
      redirect_to cars_path
    else
      redirect_to cars_path, :flash => {:danger => "Car cannot be deleted as it has a reservation."}
    end
end
  def create
    @car = Car.new(car_params)
    if @car.save
      redirect_to @car
    else
      redirect_to admins_path, :flash => { :danger => 'Adding a car failed. Try again.' }
    end
  end
  def new
    if is_customer?
      redirect_to unauthorized_show_path
    end

  end

  def update
    @car = Car.find(params[:id])

    if @car.update(car_params)
      redirect_to @car
    else
      render plain: params[:car].inspect
    end
  end

  def edit
    @car = Car.find(params[:id])
    if @car.status == "R" || @car.status == "C"
      redirect_to cars_path, :flash => {:danger => "Cannot edit a car while it is reserved or checked out"}
    end
  end

  private
  def car_params
    params.require(:cars).permit(:manufacturer, :model, :license_number, :status, :style, :rate,:location, :search)
  end
end
