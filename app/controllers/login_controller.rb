class LoginController < ApplicationController
  def new
  end
  def create
    customer = Customer.find_by(email: params[:login][:email].downcase)
    if customer && customer.authenticate(params[:login][:password])
      redirect_to customer
    else
      flash[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end
end
