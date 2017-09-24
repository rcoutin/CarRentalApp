class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

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
  	puts "1"
  	if session[:current_user] == -1
  		puts "2"
  		redirect_to unauthorized_show_path
  		puts "3"
  		return false
  	end
  return true
  end

end
