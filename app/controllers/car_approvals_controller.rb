class CarApprovalsController < ApplicationController
	def index
    if is_admin?
      @car_approvals = CarApproval.all
    else
      redirect_to customers_path, :flash => { :danger => 'Unauthorized access' }
    end
  end

  def edit
    @car_approval = CarApproval.find(params[:id])
  end

  def update
    @car_approval = CarApproval.find(params[:id])

    if @car_approval.update(car_approval_params)
      redirect_to car_approvals_path
    else
      render plain: params[:car_approval].inspect
    end
  end

  def show

  end

  def destroy
    @car_approval = CarApproval.find(params[:id])
    @customer = Customer.find(params[:customer_id])
    CarApproval.destroy(params[:id])
    redirect_to car_approvals_path
	end

  def create
    @car_approval = CarApproval.new(car_approval_params)
    if @car_approval.save
      redirect_to @car_approval
    else
      redirect_to customers_path, :flash => { :danger => 'Adding a car for approval failed.' }
    end
  end

  def new
  	if is_admin?
  		redirect_to admins_path, :flash => { :notice => 'Only customers can add cars for approval. You can directly add cars.' }
 		end
  end

  def approve
    @car = Car.new(
      manufacturer: params[:car_manufacturer],
      model: params[:car_model],
      style: params[:car_style],
      license_number: params[:car_license_number],
      location: params[:car_location],
      rate: params[:car_rate],
      status: params[:car_status]
    )
    @customer = Customer.find(params[:customer_id])
    if @car.save
      CarApproval.destroy(params[:id])
      redirect_to cars_path
    else
      redirect_to car_approvals_path, :flash => { :danger => 'Approval failed.' }
    end
  end

  private
  def car_approval_params
    params.require(:car_approval).permit(:manufacturer, :model, :license_number, :status, :style, :rate,:location, :search, :customer_id)
  end
end
