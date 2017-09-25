class LoginController < ApplicationController
  def new
    if logged_in
      @customer = Customer.find(session[:current_user])
      redirect_to @customer
    end
  end
  def create
    customer = Customer.find_by(email: params[:login][:email].downcase)
    if customer && customer.authenticate(params[:login][:password])
      sign_in customer.id, "customer"
      redirect_to customer
    elsif !customer || !customer.authenticate(params[:login][:password])
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
end
