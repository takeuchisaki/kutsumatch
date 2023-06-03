class Public::ShoesController < ApplicationController
  def new
    @shoe = Shoe.new
  end
  
  def create
  end

  def show
    @shoe = Shoe.find(params[:id])
  end

  def index
    @shoes = Shoe.all
  end

  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
    def shoe_params
      params.require(:shoe).permit(:name, :body, :maker, :sports_name, :shoes_size, :price, :match_rate)
    end
end
