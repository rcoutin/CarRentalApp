class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to @customer
    else
      render plain: params[:customer].inspect
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :password, :date_of_birth, :license_number)
  end
end
