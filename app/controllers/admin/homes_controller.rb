class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    if params[:customer_id].present?
      @customer = Customer.find(params[:customer_id])
      @shoes = @customer.shoes
                        .order(created_at: :desc)
                        .page(params[:page])
    else
      @shoes = Shoe.created_at_filters(@filter)
                  .order(created_at: :desc)
                  .page(params[:page])
    end
  end
  
end
