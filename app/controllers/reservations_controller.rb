class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  def index
    @reservations = Reservation.all
    @customers = Customer.all
    @cars = Cars.all
  end

  def show
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)

    respond_to do |process|
      if @reservation.save
        process.html{ redirect_to @reservation, notice: 'Reservation created successfully.' }
        process.json{ render :show, status :created, location: @reservation }
      end
      else
        process.html{ render :new }
        process.json{ render json: @reservation.errors, status :unprocessable_entity }
      end
  end

  def update
    respond_to do |process|
      if @reservation.update(reservation_params)
        process.html{ redirect_to @reservation, notice: 'Reservation updated.' }
        process.json{ render :show, status :ok, location: @reservation }
      end
      else
        process.html{ render :edit }
        process.json{ render json: @reservation.errors, status :unprocessable_entity }
      end
  end

  private

  def set_reservation
    @reservation = Reservation.find { params[:id]  }
  end

  def reservation_params
    params.require(:reservation).permit()#(:customer_id, :car_id, :registration_id, :registration_status)
  end

end
