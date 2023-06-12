class Public::ShoeCommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
    shoe = Shoe.find(params[:shoe_id])
    comment = current_customer.shoe_comments.new(shoe_comment_params)
    comment.shoe_id = shoe.id
    comment.save
    redirect_to request.referer
  end

  def destroy
    comment = ShoeComment.find(params[:id])
    comment.destroy
    redirect_to request.referer
  end

  private

  def shoe_comment_params
    params.require(:shoe_comment).permit(:comment)
  end

end
