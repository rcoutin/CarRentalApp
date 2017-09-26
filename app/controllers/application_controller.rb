class  ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :check_unauthorized_access

  @@allowed_controllers = ["login", "admins_login", "admin"]
  @@disallowed_actions = ["index", "show", "edit"]

  def sign_in(user_id, user_type)
  	session[:current_user] = user_id
  	session[:user_type] = user_type
  end

  def sign_out
  	session[:current_user] = -1
  	session[:user_type] = false
  	puts "Wrong redirection possible here"
  	redirect_to new_login_path
  end
  helper_method :sign_out

  def check_authority
  	if session[:current_user] == -1
  		redirect_to unauthorized_show_path
  		return false
  	end
  return true
  end

  def logged_in
    puts params[:action]
  	if session[:current_user] && session[:current_user] != -1
  		return true
  	end
  	return false
  end

  def check_unauthorized_access
    if !logged_in && !@@allowed_controllers.include?(params[:controller]) && @@disallowed_actions.include?(params[:action])
      redirect_to new_login_path
    end
  end

  def is_customer?
    if session[:user_type] == "customer"
      return true
    end
    return false
  end
  helper_method :is_customer?

  def is_super_admin?
    if session[:user_type] == "super_admin"
      return true
    end
    return false
  end
  helper_method :is_super_admin?

  def is_admin?
    if session[:user_type] == "admin"
      return true
    end
    return false
  end
  helper_method :is_admin?
end
