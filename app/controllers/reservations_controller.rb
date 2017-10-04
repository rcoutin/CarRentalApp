require 'rubygems'

class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  def index
    if is_admin?
      @reservations = Reservation.all
    else
      @reservations = Reservation.where(:customer_id => session[:current_user])
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


  def create
    @reservation = Reservation.new(reservation_params)

    begin
    if @reservation.save
      Car.set_status(params[:reservation][:car_id],"R")
      Rufus::Scheduler.singleton.at @reservation.from_time + (4 * 60 * 60).seconds + 30.minutes do
        if(Car.find(params[:reservation][:car_id]).status == "R")
          Reservation.destroy(@reservation.id)
          Car.set_status(@reservation.car_id,"A")
          puts "A Set"
        end
      end
      redirect_to @reservation, :flash => { :success => 'Reserved' }
    else
      #redirect_to cars_path, :flash => { :danger => "Please enter correct values while reserving" }
      flash.now[:danger] = "Please enter correct values while reserving"
      render action: "new"
    end
    rescue ActiveRecord::RecordNotUnique => e
      redirect_to cars_path, :flash => { :danger => "Reservation already present" }
    end
  end

  def update
      if @reservation.update(reservation_params)
        redirect_to @reservation, :flash => { :success => 'Reservation successfulyl updated' }
      else
        redirect_to @reservation, :flash => { :danger => 'Problem in updating' }
      end
  end

  def edit
  end
#checking out the car
  def checkout
    Car.set_status(params[:car_id],"C")
    redirect_to reservations_path
  end
#cancel the reservation
  def cancel
    Reservation.destroy(params[:reservation_id])
    #Car.find(params[:car_id]).update(:status => "A")
    Car.set_status(params[:car_id],"A")

    redirect_to reservations_path
  end

  def return
     cancel
  end

  private
  def set_reservation
    @reservation = Reservation.find { params[:id]  }
  end

  def reservation_params
    params.require(:reservation).permit(:customer_id, :car_id, :from_time, :to_time)
  end

  def check_status(car_id)
    if(Car.find(car_id) == "R")
      Car.set_status(car_id,"A")
    end
  end

end
