class Public::ShoeCommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @shoe = Shoe.find(params[:shoe_id])
    comment = current_customer.shoe_comments.new(shoe_comment_params)
    comment.shoe_id = @shoe.id
    comment.save
  end

  def destroy
    @shoe = Shoe.find(params[:shoe_id])
    comment = ShoeComment.find(params[:id])
    comment.destroy
  end

  private

  def shoe_comment_params
    params.require(:shoe_comment).permit(:comment)
  end

end
