class NotificationsController < ApplicationController


 def new
   @notification = Notification.new
 end
 

 def show
 end

 def create
    @notification = Notification.new({:customer_id => current_user, :car_id => params[:car_id]})
  if  @notification.save
    redirect_to cars_path
  else 
    flash.now[:info] = "You will be notified by email once the car is available!"
  end    
 end

 def edit
 end

 def update
 end

 private 
 def notification_params
    params.require(:notification).permit(:customer_id,:car_id)
 end

end
