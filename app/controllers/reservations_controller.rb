require 'rubygems'

class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  #after_action :create_history


  def index
    if is_customer?
    @reservations = Reservation.where(:customer_id => params[:res_for_customer])
    elsif is_admin?
    @reservations = Reservation.all
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

      Rufus::Scheduler.singleton.at @reservation.to_time  + (4 * 60 * 60).seconds do
        if(Car.find(params[:reservation][:car_id]).status == "C")
          Reservation.destroy(@reservation.id)
          Car.set_status(@reservation.car_id,"A")
          @car = Car.find(@reservation.car_id)
          @customer = Customer.find(@reservation.customer_id)
          UserMailer.notification_return(@customer, @car).deliver_now
          puts "A Set"
        end
      end
      redirect_to @reservation, :flash => { :success => 'Reserved' }
    else
      #redirect_to cars_path, :flash => { :danger => "Please enter correct values while reserving" }
      flash.now[:danger] = "Please enter correct values while reserving"
      redirect_to cars_path, :flash => { :danger => "Invalid parameters, please try again!" }
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
    if is_customer?
      redirect_to reservations_path, :flash => { :danger => 'Cannot edit after reservation. Contact Administrator for support.'}
    end
  end
#checking out the car
  def checkout
    Car.set_status(params[:car_id],"C")
    redirect_to reservations_path(:res_for_customer => current_user)
  end
#cancel the reservation
  def cancel
    Reservation.destroy(params[:reservation_id])
    Car.find(params[:car_id]).update(:status => "A")
    create_history(params)
    redirect_to reservations_path(:res_for_customer => current_user)
  end

  def return
    Reservation.destroy(params[:reservation_id])
    car = Car.find(params[:car_id])
    car.update(:status => "A")
    @notifications = Notification.where(:car_id => params[:car_id])
    @notifications.each do |notification|
      customer = Customer.find(notification.customer_id)
      UserMailer.notification_available(customer, car).deliver_now
    end
    create_history(params)
    redirect_to reservations_path(:res_for_customer => current_user)
  end

  private
  def set_reservation
    @reservation = Reservation.find { params[:id]  }
  end

  def reservation_params
    params.require(:reservation).permit(:customer_id, :car_id, :from_time, :to_time)
  end


  #create a reservation history after cancellation, deletion and completion
  def create_history(res_map)
    puts res_map
    @reservation_history = ReservationHistory.new(reservation_id: res_map[:reservation_id],
    customer_id: res_map[:customer_id],
    car_id: res_map[:car_id],
    from_time: res_map[:from_time],
    to_time: res_map[:to_time],)
    if !@reservation_history.save
      flash.now[:danger] = "Could not save reservation history"

    end
  end




end
