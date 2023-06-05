class Public::ShoeCommentsController < ApplicationController
  
  def create
    shoe = Shoe.find(params[:shoe_id])
    comment = ShoeComment.new(shoe_comment_params)
    comment.customer_id = current_customer.id
    comment.shoe_id = shoe.id
    comment.save
    redirect_to shoe_path(shoe)
  end
  
  def destroy
    comment = ShoeComment.find(params[:id])
    comment.destroy
    redirect_to shoe_path(params[:shoe_id])
  end
  
  private
  
  def shoe_comment_params
    params.require(:shoe_comment).permit(:comment)
  end
  
end
