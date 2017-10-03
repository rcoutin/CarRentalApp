class AdminsLoginController < ApplicationController
	def new
    if logged_in
      @admin = Admin.find(session[:current_user])
      redirect_to @admin
    end
  end
  def create
    admin = Admin.find_by(email: params[:admins_login][:email].downcase)
    if admin && admin.authenticate(params[:admins_login][:password])
    	if admin.is_super_admin
      	sign_in admin.id, "super_admin"
      else
      	sign_in admin.id, "admin"
      end
  
      redirect_to admin
    else
      redirect_to new_admins_login_path, :flash => { :danger => "Incorrect username and password" }
    end
  end
end
