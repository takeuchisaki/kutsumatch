class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!

  def search
    @range =  params[:range]
    @word = params[:word]
    @current_page = "searches"

    # タグの検索
    if @range == "Tag"
      @tags = Tag.search(@word)
    # ユーザーの検索
    elsif @range == "Customer"
      @customers = Customer.customer_search(@word)
                           .where.not(id: current_customer.id)
                           .where.not(name: "guestcustomer")
                           .page(params[:page])
    else
      # タグのIDが指定されている場合
      if params[:tag_id].present?
        @tag = Tag.find(params[:tag_id])
        @shoes = @tag.shoes
                     .order(created_at: :desc)
                     .page(params[:page])
      else
        # ワードで投稿を検索
        @shoes = Shoe.shoe_search(@word)
                     .order(created_at: :desc)
                     .page(params[:page])
      end
    end
    render "public/searches/search"
  end

end
