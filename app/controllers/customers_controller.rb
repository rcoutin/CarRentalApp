class CustomersController < ApplicationController
  def show
    if check_authority
      @customer = Customer.find(session[:current_user])
    end
  end

  def new
  end

  def create
    @customer = Customer.new(customer_params)
    puts params[:customer]

    if @customer.save
      redirect_to new_login_path
    else
      render plain: params[:customer].inspect
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :password, :date_of_birth, :license_number)
  end
end
