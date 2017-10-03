class  ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_unauthorized_access

  @@allowed_controllers = ["login", "admins_login","customers"]
  @@disallowed_actions = ["index", "edit"]
  @@admin_roles = ["admin","super_admin"]

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
  	(current_user && current_user != -1)? true:false
  end

  def check_unauthorized_access
   if !logged_in && !(@@allowed_controllers.include?(params[:controller]) && !@@disallowed_actions.include?(params[:action]))
      redirect_to new_login_path
    end
  end

  def is_customer?
    user_type == "customer"? true:false
  
  end
  helper_method :is_customer?

  def is_super_admin?
    user_type == "super_admin" ? true:false
  end
  helper_method :is_super_admin?

  def is_admin?
    @@admin_roles.include?(user_type)? true:false
  end
  helper_method :is_admin?
end