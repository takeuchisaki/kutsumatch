class Admin::ShoeCommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    if params[:shoe_id].present?
      @shoe = Shoe.find(params[:shoe_id])
      @shoe_comments = @shoe.shoe_comments
    elsif params[:customer_id].present?
      @customer = Customer.find(params[:customer_id])
      @shoe_comments = @customer.shoe_comments
    else
      @shoe_comments = ShoeComment.all
    end
  end

  def show
    @shoe_comment = ShoeComment.find(params[:id])
    @customer = @shoe_comment.customer
    @shoe = @shoe_comment.shoe
  end

  def destroy
    shoe_comment = ShoeComment.find(params[:id])
    shoe_comment.destroy
    redirect_to admin_shoe_comments_path
  end
  
end
