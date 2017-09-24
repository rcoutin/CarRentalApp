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
    #@reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
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
    end
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
