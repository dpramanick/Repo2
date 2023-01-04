# frozen_string_literal: true

# rubocop:disable Style/Documentation

class SearchController < ApplicationController
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end
end

# rubocop:enable Style/Documentation
