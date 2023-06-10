class Public::ShoesController < ApplicationController
  def new
    @shoe = Shoe.new
  end

  def create
    @shoe = Shoe.new(shoe_params)
    @shoe.customer_id = current_customer.id
    tag_list = params[:shoe][:tag_name].split("、")
    if @shoe.save
      @shoe.save_tag(tag_list)
      redirect_to shoe_path(@shoe)
    else
      render :new
    end
  end

  def show
    @shoe = Shoe.find(params[:id])
    @shoe_comment = ShoeComment.new
    @customer = @shoe.customer
    @shoe_tags = @shoe.tags
  end
  
  # def index
  #   @q = Shoe.ransack(params[:q])
  #   @shoes = @q.result(distinct: true)
  # end
  
  def index
    @shoes = Shoe.search_by_filters(params)
    @customers = Customer.search_by_filters(params)
  end
  # def index
  #   if params[:tag_id].present?
  #     @tag = Tag.find(params[:tag_id])
  #     @shoes = @tag.shoes
  #   else
  #     @shoes = Shoe.all
  #   end
  #   @tag_lists = Tag.all
  # end

  def edit
    @shoe = Shoe.find(params[:id])
  end

  def update
    @shoe = Shoe.find(params[:id])
    tag_list = params[:shoe][:tag_name].split("、")
    if @shoe.update(shoe_params)
      @shoe.save_tag(tag_list)
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

  # def search_tag
  #   @tag_lists = Tag.all
  #   @tag = Tag.find(params[:tag_id])
  #   @shoes = @tag.shoes
  # end

  private

  def shoe_params
    params.require(:shoe).permit(:name, :body, :shoe_size, :price, :match_rate, :shoe_image, :tag_name)
  end
end
