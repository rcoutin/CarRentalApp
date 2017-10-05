class CustomersController < ApplicationController
  def index
    if is_admin?
      @customers = Customer.all
    else
      redirect_to unauthorized_show_path
    end
  end

  def show
    @customer = Customer.find(params[:id])
    if is_admin?
   @reservation_hist = ReservationHistory.joins("JOIN cars ON cars.id = reservation_histories.car_id").where(:customer_id => params[:id]).select("cars.*, reservation_histories.*")
  end
  end

  def new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      UserMailer.welcome_email(@customer).deliver_later
      flash.now[:info] = "You have successfully signed up!"
      redirect_to new_login_path
    else
      render plain: params[:customer].inspect
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  
  def destroy
    Customer.destroy(params[:id])
    flash.now[:danger] = "The Customer has been deleted"
    redirect_to customers_path

  end
  def update
    @customer = Customer.find(params[:id])

    if @customer.update_attributes(customer_params)
      redirect_to @customer
    else
      render plain: params[:customer].inspect
    end
  end

  def pay
    print params
    @customer = Customer.find(params[:id])
    @customer.rental_charge = 0.0
    if @customer.save
      redirect_to root_path
    else
      redirect_to root_path, :flash => {:danger => "Paying failed. Try again."}
    end
  end
  private
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :password, :date_of_birth, :license_number)
  end
end
