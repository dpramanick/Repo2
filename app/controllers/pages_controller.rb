# frozen_string_literal: true

# rubocop:disable Style/Documentation

class PagesController < ApplicationController
  def home
    @s_cat = params[:s_cat]
    $glow = params[:glow]
    @random_product = Product.order('RANDOM()').first
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end

  def map
    @user = current_user
  end

  def account
    @account = current_user
    @purchase = current_user.payments
  end


end

# rubocop:enable Style/Documentation
