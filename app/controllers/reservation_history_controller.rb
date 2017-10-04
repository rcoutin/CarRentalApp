class ReservationHistoryController < ApplicationController

def new
@reservation_hist = ReservationHistory.new
end

def create
end

def show
end

def index
if is_customer?
        @reservation_hist= ReservationHistory.where(:customer_id => current_user)

elsif is_admin?
        @reservation_hist=  ReservationHistory.all 

end
end


def reservation_hist_params
        params.require(:reservation).permit(:customer_id, :car_id, :from_time, :to_time)
end

end
