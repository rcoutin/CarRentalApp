class AdminsController < ApplicationController
  def index
    @admins = Admin.all
  end

  def show
    if check_authority && !is_customer?
      @admin = Admin.find(session[:current_user])
    else
      redirect_to unauthorized_show_path
    end
  end

  def new
    if is_customer?
      redirect_to unauthorized_show_path
    end
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      redirect_to new_login_path
    else
      render plain: params[:admin].inspect
    end
  end

  private
  def admin_params
    params.require(:admin).permit(:first_name, :last_name, :email, :password, :is_super_admin)
  end
end
