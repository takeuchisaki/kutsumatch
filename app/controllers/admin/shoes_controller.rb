class Admin::ShoesController < ApplicationController
  def index
    @shoes = Shoe.all
  end

  def show
    @shoe = Shoe.find(params[:id])
    @customer = @shoe.customer
    @shoe_tags = @shoe.tags
  end

  def destroy
    shoe = Shoe.find(params[:id])
    shoe.destroy
    redirect_to admin_root_path
  end
end
