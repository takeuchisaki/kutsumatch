class Admin::ShoeCommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    if params[:shoe_id].present?
      @shoe = Shoe.find(params[:shoe_id])
      @shoe_comments = @shoe.shoe_comments
                            .order(created_at: :desc)
                            .page(params[:page])
    elsif params[:customer_id].present?
      @customer = Customer.find(params[:customer_id])
      @shoe_comments = @customer.shoe_comments
                                .order(created_at: :desc)
                                .page(params[:page])
    else
      @filter = params[:filter]
      @shoe_comments = ShoeComment.comment_cocreated_at_filters(@filter)
                                  .order(created_at: :desc)
                                  .page(params[:page])
    end
  end

  def show
    @shoe_comment = ShoeComment.find(params[:id])
    @customer = @shoe_comment.customer
    @shoe = @shoe_comment.shoe
    @shoe_tags = @shoe.tags
  end

  def destroy
    shoe_comment = ShoeComment.find(params[:id])
    shoe_comment.destroy
    redirect_to admin_shoe_comments_path
  end
  
end
