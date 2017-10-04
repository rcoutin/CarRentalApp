class  ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :check_unauthorized_access

  @@allowed_controllers = ["login", "admins_login","customers"]
  @@disallowed_actions = ["index", "edit"]
  @@admin_roles = ["admin","super_admin"]

  def get_user_name
    if is_admin?
      @user = Admin.find(current_user)
    elsif is_customer?
      @user = Customer.find(current_user)
    end
    @user.first_name + " " + @user.last_name
  end
  helper_method :get_user_name

  def current_user
    session[:current_user]
  end
  helper_method :current_user
  
  def user_type
    session[:user_type]
  end 

  def sign_in(user_id, user_type)
  	session[:current_user] = user_id
  	session[:user_type] = user_type
  end

  def sign_out
  	session[:current_user] = -1
  	session[:user_type] = false
  	redirect_to new_login_path
  end
  helper_method :sign_out

  def check_authority
  	if current_user == -1
  		redirect_to unauthorized_show_path
  		return false
  	end
  return true
  end

  def logged_in
  	current_user && current_user != -1
  end
  helper_method :logged_in

  def check_unauthorized_access
   if !logged_in && !(@@allowed_controllers.include?(params[:controller]) && !@@disallowed_actions.include?(params[:action]))
      redirect_to new_login_path
    end
  end

  def is_customer?
    user_type == "customer"
  
  end
  helper_method :is_customer?

  def is_super_admin?
    user_type == "super_admin"
  end
  helper_method :is_super_admin?

  def is_admin?
    @@admin_roles.include?(user_type)
  end
  helper_method :is_admin?


end