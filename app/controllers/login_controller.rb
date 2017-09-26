class LoginController < ApplicationController
  def new
    if logged_in && is_customer?
      @customer = Customer.find(session[:current_user])
      redirect_to @customer
    end
    if logged_in & !is_customer?
      @admin = Admin.find(session[:current_user])
      redirect_to @admin
    end
  end
  def create
    customer = Customer.find_by(email: params[:login][:email].downcase)
    if customer && customer.authenticate(params[:login][:password])
      sign_in customer.id, "customer"
      redirect_to customer
    elsif !customer || !customer.authenticate(params[:login][:password])
      flash.now[:danger] = 'Invalid email/password combination'
      render :action => :new
    end
  end
end
