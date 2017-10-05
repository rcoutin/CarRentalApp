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
    time_val = validate_time(@reservation.from_time, @reservation.to_time);
    if time_val.empty? && @reservation.save
      Car.set_status(params[:reservation][:car_id],"R")

      # SCHEDULER TO CHECK WHETHER CAR IS CHECKED OUT WITHIN 30 MINUTES

      Rufus::Scheduler.singleton.at @reservation.from_time + (4 * 60 * 60).seconds + 30.minutes do
        if(Car.find(params[:reservation][:car_id]).status == "R")
          Reservation.destroy(@reservation.id)
          Car.set_status(@reservation.car_id,"A")

          create_history(params[:reservation])
        end
      end

      # SCHEDULER TO CHECK WHETHER CAR IS RETURNED ON TIME

      Rufus::Scheduler.singleton.at @reservation.to_time  + (4 * 60 * 60).seconds do
        if(Car.find(params[:reservation][:car_id]).status == "C")
          Reservation.destroy(@reservation.id)
          Car.set_status(@reservation.car_id,"A")

          @car = Car.find(@reservation.car_id)
          @customer = Customer.find(@reservation.customer_id)

          create_history(params[:reservation])

          UserMailer.notification_return(@customer, @car).deliver_now
         
        end
      end
      redirect_to @reservation, :flash => { :success => 'Reserved' }
    else
      #redirect_to cars_path, :flash => { :danger => "Please enter correct values while reserving" }
      flash.now[:danger] = "Please enter correct values while reserving"
      redirect_to cars_path, :flash => { :danger => "Invalid parameters, please try again! ".concat(time_val) }
    end
    rescue ActiveRecord::RecordNotUnique => e
      redirect_to cars_path, :flash => { :danger => "Reservation already present" }
    end
  end

  def update
      if @reservation.update(reservation_params)
        redirect_to @reservation, :flash => { :success => 'Reservation successfully updated' }
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
    total_time = calculate_time_difference(params)

    if(total_time >= 0)
      Car.set_status(params[:car_id],"C")
      redirect_to reservations_path(:res_for_customer => current_user)
    else
      redirect_to root_path, :flash => {:danger => "Cannot checkout before reserved time. Please try again later."}
    end
  end
#cancel the reservation
  def cancel
    Reservation.destroy(params[:reservation_id])
    Car.find(params[:car_id]).update(:status => "A")
    redirect_to reservations_path(:res_for_customer => current_user)
  end

  def return
    car = Car.find(params[:car_id])
    car.update(:status => "A")
    notifications = Notification.where(:car_id => params[:car_id]).select(:customer_id)
    customer_ids =[]
    notifications.each {|n| customer_ids << n.customer_id}
    customers = Customer.where(:id => customer_ids)
    customers.each{|customer_obj| UserMailer.notification_available(customer_obj, car).deliver_later}
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
    
    charge_per_hour = (Car.find(res_map[:car_id]).rate)

    total_time = calculate_time_difference(res_map)

    @total_charge = total_time * charge_per_hour

    @customer = Customer.find(res_map[:customer_id])

    @customer.increment('rental_charge', @total_charge.round(2))

    @reservation_history = ReservationHistory.new(reservation_id: res_map[:reservation_id],
    customer_id: res_map[:customer_id],
    car_id: res_map[:car_id],
    from_time: res_map[:from_time],
    to_time: DateTime.now,
    total_charges: @total_charge.round(2))

    if !@reservation_history.save
      flash.now[:danger] = "Could not save reservation history"
    end

    if !@customer.save
      flash.now[:danger] = "Cound not update customer value"
    end
  end

  def validate_time(from_time,to_time)
    msg = ''
    if from_time == nil
      msg =  'Invalid time entry.'
    elsif to_time == nil
      msg =  'Invalid time entry.'
 		elsif ((from_time - DateTime.now) + ( 4 * 60 * 60 )) < 0
 		 msg =  'Time cannot be in the past.'
 		elsif (from_time - DateTime.now) / 24 / 60 / 60 > 7
      msg =  'The reservation time has to be in the next one week.'
  	elsif to_time < from_time
      msg =  'The time cannot be before the initial reservation time.'
  	elsif to_time - from_time < 3600
      msg =  'The minimum reservation time is 1 hour.'
  	elsif to_time - from_time > 36000
      msg =  'The maximum reservation time is 10 hours.'
    end
    return msg
  end

  def calculate_time_difference(map)
    current_time = (DateTime.now).hour.to_f + ((DateTime.now).min.to_f / 60) - 4
    from_time = (DateTime.parse(map[:from_time])).hour.to_f + (DateTime.parse(map[:from_time])).min.to_f / 60

    if current_time < 12 && from_time >= 12
      current_time += 24
    end

    total_time = (current_time - from_time).to_f
   
    return total_time
  end



end
