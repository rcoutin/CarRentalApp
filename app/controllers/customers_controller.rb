class CustomersController < ApplicationController
  def index
    if is_admin?
      @customers = Customer.all
    else
      redirect_to unauthorized_show_path
    end
  end

  def show

   # if is_admin?
      
      @customer = Customer.find(current_user)

    #if check_authority
   # end
  end

  def new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to new_login_path
    else
      render plain: params[:customer].inspect
    end
  end

  def edit
    @customer = Customer.find(current_user)
  end
def destroy
  Customer.destroy(params[:id])
  flash.now[:danger] = "The Customer has been deleted"
  redirect_to customers_path

end
  def update
    @customer = Customer.find(current_user)

    if @customer.update_attributes(customer_params)
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
