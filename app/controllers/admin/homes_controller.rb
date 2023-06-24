class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    if params[:customer_id].present?
      @customer = Customer.find(params[:customer_id])
      @shoes = @customer.shoes.page(params[:page])
    else
      @shoes = Shoe.page(params[:page])
    end
  end
  
end
