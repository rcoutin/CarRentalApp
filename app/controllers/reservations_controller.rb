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
    
    if validate_time(@reservation.from_time, @reservation.to_time) && @reservation.save
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
     # redirect_to new_reservation_path, :flash => { :danger => "Please enter correct values while reserving" }
     flash.now[:danger] = "Please enter correct values while reserving"
      #render action: "new"
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
    car = Car.find(params[:car_id])
    car.update(:status => "A")
    notifications = Notification.where(:car_id => params[:car_id]).select(:customer_id)
    customer_ids =[]
    notifications.each {|n| customer_ids << n.customer_id}
    customers = Customer.where(:id => customer_ids)
    customers.each{|customer_obj| UserMailer.notification_available(customer_obj, car).deliver_now}
    notifications.delete_all
    create_history(params)
    Reservation.destroy(params[:reservation_id])
    redirect_to reservations_path(:res_for_customer => current_user)
  end

  private
  def set_reservation
    @reservation = Reservation.find { params[:id]  }
  end

  def reservation_params
    params.require(:reservation).permit(:customer_id, :car_id, :from_time, :to_time, :car_id, :car_model, :car_manufacturer)
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

  def validate_time(from_time,to_time)
    status = true;
    if from_time == nil
      #errors.add(:from_time, 'Invalid time entry.')
      puts "1"
      return false
    elsif to_time == nil
     # errors.add(:to_time, 'Invalid time entry.')
      puts "2"
      return false
 		elsif ((from_time - DateTime.now) + ( 4 * 60 * 60 )) < 0
 		#	errors.add(:from_time, 'Time cannot be in the past.')
      puts "3"
      return false
 		elsif (from_time - DateTime.now) / 24 / 60 / 60 > 7
 			#errors.add(:from_time, 'The reservation time has to be in the next one week.')
      puts "4"
      return false
  	elsif to_time < from_time
  	#	errors.add(:to_time, 'The time cannot be before the initial reservation time.')
      puts "5"
      return false
  	elsif to_time - from_time < 3600
  		#errors.add(:to_time, 'The minimum reservation time is 1 hour.')
      puts "6"
      return false
      puts to_time - from_time
  	elsif to_time - from_time > 36000
      #errors.add(:to_time, 'The maximum reservation time is 10 hours.')
      return false
      puts "7"
    end
    return status
  end

end
