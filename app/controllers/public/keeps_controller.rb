class Public::KeepsController < ApplicationController
  before_action :authenticate_customer!

  def create
    shoe = Shoe.find(params[:shoe_id])
    keep = current_customer.keeps.new(shoe_id: shoe.id)
    keep.save
    redirect_to request.referer
  end

  def destroy
    shoe = Shoe.find(params[:shoe_id])
    keep = current_customer.keeps.find_by(shoe_id: shoe.id)
    keep.destroy
    redirect_to request.referer
  end

end
