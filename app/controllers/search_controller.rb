class SearchController < ApplicationController

  def index
    @s_cat = params[:s_cat]
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end
end
