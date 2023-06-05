class Public::ShoesController < ApplicationController
  def new
    @shoe = Shoe.new
  end

  def create
    shoe = Shoe.new(shoe_params)
    shoe.customer_id = current_customer.id
    if shoe.save
      redirect_to shoe_path(shoe)
    else
      render :new
    end
  end

  def show
    @shoe = Shoe.find(params[:id])
    @shoe_comment = ShoeComment.new
  end

  def index
    @shoes = Shoe.all
  end

  def edit
    @shoe = Shoe.find(params[:id])
  end

  def update
    @shoe = Shoe.find(params[:id])
    if @shoe.update(shoe_params)
      redirect_to shoe_path(@shoe)
    else
      render :edit
    end
  end

  def destroy
    shoe = Shoe.find(params[:id])
    shoe.destroy
    redirect_to customer_path(current_customer)
  end

  private

  def shoe_params
    params.require(:shoe).permit(:name, :body, :maker, :sports_name, :shoes_size, :price, :match_rate, :genre_id)
  end
end
