class Public::SearchesController < ApplicationController

  def search
    @range =  params[:range]
    @word = params[:word]
    if @range == "shoe"
      @shoes = Shoe.search(@word)
      render "public/searches/search"
    elsif @range == "Tag"
      @tags = Tag.search(@word)
      render "public/searches/search"
    elsif @range == "User"
      @customers = Customer.search(@word)
      render "public/searches/search"
    else
      @shoes = Shoe.search(@word)
      @tags = Tag.search(@word)
      @users = Customer.search(@word)
      render "public/searches/search"
    end
  end
end
