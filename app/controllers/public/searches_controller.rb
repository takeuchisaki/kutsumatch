class Public::SearchesController < ApplicationController
  
  def search
    @range =  params[:range]
    @word = params[:word]
    if @range == "shoe"
      @shoes = Shoe.searchs(@word)
      render "searches/search"
    elsif @range == "Tag"
      @tags = Tag.searchs(@word)
      render "searches/search"
    elsif @range == "User"
      @customers = Customer.searchs(@word)
      render "searches/search"
    else
      @shoes = Shoe.searchs(@word)
      @tags = Tag.searchs(@word)
      @users = User.searchs(@word)
      render "searches/search"
    end
  end
end
