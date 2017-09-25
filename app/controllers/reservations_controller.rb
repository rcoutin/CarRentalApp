class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  def index
    @reservations = Reservation.all
    @customers = Customer.all
    @cars = Car.all
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = Reservation.new
    # @reservation.from_time = Time.now.strftime("%FT%T")
    # @reservation.to_time = Time.now.strftime("%FT%T")
  end

  def create
    @reservation = Reservation.new(reservation_params)
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

  private

  def set_reservation
    @reservation = Reservation.find { params[:id]  }
  end

  def reservation_params
    params.require(:reservation).permit(:customer_id, :car_id, :from_time, :to_time)
  end

end
