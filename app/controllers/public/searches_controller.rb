class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!

  def search
    @range =  params[:range]
    @word = params[:word]

    # タグの検索
    if @range == "Tag"
      @tags = Tag.search(@word)
    # ユーザーの検索
    elsif @range == "Customer"
      @customers = Customer.search(@word).where.not(id: current_customer.id).where.not(name: "guestcustomer")
    else
      # タグのIDが指定されている場合
      if params[:tag_id].present?
        @tag = Tag.find(params[:tag_id])
        @shoes = @tag.shoes
      else
        # ワードで投稿を検索
        @shoes = Shoe.search(@word)
      end
    end
    render "public/searches/search"
  end

end
