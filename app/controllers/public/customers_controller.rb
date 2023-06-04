class Public::CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
    @shoes = @customer.shoes
  end

  def index
    @customers = Customer.all
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer)
    else
      render :edit
    end
  end

  def confirm
  end

  def withdraw
    customer = current_customer
    customer.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "退会手続きが完了しました"
  end

  private

  def customer_params
    params.require(:customer).permit(:foot_size, :foot_width, :foot_types, :gender, :introduction)
  end

end
