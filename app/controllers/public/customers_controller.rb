class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :is_matching_login_customer, only: [:edit, :update, :withdraw]
  before_action :ensure_guest_customer,      only: [:edit, :update]

  def show
    @customer = Customer.find(params[:id])
    @shoes = @customer.shoes
  end

  def index
    @customers = Customer.search_by_filters(params).where.not(id: current_customer.id).where.not(name: "guestcustomer")
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "更新しました。"
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
    flash[:notice] = "退会手続きが完了しました。"
    redirect_to root_path
  end

  def keeps
    keeps = current_customer.keeps.pluck(:shoe_id)
    @keep_shoes = Shoe.find(keeps)
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :foot_size, :foot_width, :foot_type, :gender, :introduction, :is_deleted, :profile_image)
  end

  def is_matching_login_customer
    customer = Customer.find(params[:id])
    unless customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end

  def ensure_guest_customer
    customer = Customer.find(params[:id])
    if customer.name == "guestcustomer"
      flash[:notice] = "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      redirect_to customer_path(current_customer)
    end
  end

end
