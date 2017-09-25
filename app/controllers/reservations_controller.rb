class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  def index

    if session[:user_type] == 'admin'

    @reservations = Reservation.all
      else
      @reservations = Reservation.where(:customer_id => session[:current_user])
      @cars = Car.joins("INNER JOIN reservations ON cars.id = reservations.car_id").select(:id, :status)
      @cars.each { |x| params[x.id.to_s] = x.status}
      puts params

      end
  end
  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = Reservation.new
    # @reservation.from_time = Time.now.strftime("%FT%T")
    # @reservation.to_time = Time.now.strftime("%FT%T")
  end
#Set the status of the car to R when a user reserves it
  def car_status=(status)
    car = Car.find(params[:reservation][:car_id])
    Car.update(:status => status)
  end

  def create
    @reservation = Reservation.new(reservation_params)
    car_status = "R"
    begin
      respond_to do |process|
        if @reservation.save
          process.html{ redirect_to @reservation, notice: 'Reservation created successfully.' }
          process.json{ render :show, status: created, location: @reservation }
        else
          process.html{ render :new }
          process.json{ render json: @reservation.errors, status: unprocessable_entity }
        end
      end
    rescue ActiveRecord::RecordNotUnique => e
      respond_to do |process|
        process.html{ render :new, notice: 'Cannot reserve!'}
        process.json{ render json: @reservation.errors, status: unprocessable_entity }
      end
    if @reservation.save
      flash.now[:success] = 'Reservation created successfully.'
      redirect_to @reservation
    else
      flash.now[:danger] = "Wrong Entries."
      redirect_to cars_path
    end
    rescue ActiveRecord::RecordNotUnique => e
        flash.now[:danger] = 'Cannot reserve!'
        redirect_to cars_path
    
  end

  def update
    respond_to do |process|
      if @reservation.update(reservation_params)
        process.html{ redirect_to @reservation, notice: 'Reservation updated.' }
        process.json{ render :show, status: ok, location: @reservation }
        else
          process.html{ render :edit }
          process.json{ render json: @reservation.errors, status: unprocessable_entity }
        end
      end
  end

  def edit
  end
#checking out the car
  def checkout
    car_status  = "C"
  end
#cancel the reservation
  def cancel

    car_status = "A"
  end

  def car_status

  end
  private

  def set_reservation
    @reservation = Reservation.find { params[:id]  }
  end

  def reservation_params
    params.require(:reservation).permit(:customer_id, :car_id, :from_time, :to_time)
  end

end
