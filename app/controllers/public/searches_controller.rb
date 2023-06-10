class Public::SearchesController < ApplicationController

  def search
    @range =  params[:range]
    @word = params[:word]
    if @range == "shoe"
      @shoes = Shoe.search(@word)
    elsif @range == "Tag"
      @tags = Tag.search(@word)
    elsif @range == "User"
      @customers = Customer.search(@word)
    else
      @shoes = Shoe.search(@word)
    end
    render "public/searches/search"
  end
  
end
