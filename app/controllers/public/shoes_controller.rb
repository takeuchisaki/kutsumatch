class Public::ShoesController < ApplicationController
  before_action :authenticate_customer!
  before_action :is_matching_login_customer, only: [:edit, :update, :destroy]

  def new
    @shoe = Shoe.new
    @current_page = "shoe_new"
  end

  def create
    @shoe = Shoe.new(shoe_params)
    @shoe.customer_id = current_customer.id
    @shoe.score = Language.get_data(shoe_params[:body])
    @shoe.match_rate = Language.get_percentage(@shoe.score)
    tag_list = params[:shoe][:tag_name].split("、")
    if @shoe.save
      @shoe.save_tag(tag_list)
      flash[:notice] = "投稿完了しました。"
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

  def index
    @shoes = Shoe.search_by_shoe_filters(params)
                 .search_by_customer_filters(params)
                 .order(created_at: :desc)
                 .page(params[:page])
    @current_page = "shoes"
  end

  def edit
    @shoe = Shoe.find(params[:id])
  end

  def update
    @shoe = Shoe.find(params[:id])
    @shoe.score = Language.get_data(shoe_params[:body])
    @shoe.match_rate = Language.get_percentage(@shoe.score)
    tag_list = params[:shoe][:tag_name].split("、")
    if @shoe.update(shoe_params)
      @shoe.save_tag(tag_list)
      flash[:notice] = "更新が完了しました。"
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
    params.require(:shoe).permit(:name, :body, :shoe_size, :price, :shoe_image, :tag_name)
  end

  def is_matching_login_customer
    shoe = Shoe.find(params[:id])
    unless shoe.customer == current_customer
      redirect_to shoes_path
    end
  end

end
