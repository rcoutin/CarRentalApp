class AdminsController < ApplicationController
  def show
    if check_authority
      @admin = Admin.find(session[:current_user])
    end
  end

  def new
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