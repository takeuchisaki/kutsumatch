class Public::CustomersController < ApplicationController
  before_action :set_customer, only: [:keeps]

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

  def keeps
    keeps = Keep.where(customer_id: @customer.id).pluck(:shoe_id)
    @keep_shoes = Shoe.find(keeps)
  end

  private

  def customer_params
    params.require(:customer).permit(:foot_size, :foot_width, :foot_type, :gender, :introduction, :is_deleted, :profile_image)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end

end
