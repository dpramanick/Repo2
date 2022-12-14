# frozen_string_literal: true

# rubocop:disable Style/Documentation, Metrics/AbcSize

class ProductsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show buyer]
  before_action :set_product, only: [:show]
  before_action :set_user_product, only: %i[edit update destroy]
  before_action :set_categories

  def index
    @products = Product.newest_first
    @products = @products.search(params[:category_id]) if params[:category_id].present?
    @products = @products.condition_id(params[:condition_id]) if params[:condition_id].present?
    return unless params[:category_id].present?

    @products = @products.category_id(params[:category_id])
  end

  def buyer
    @products = Product.newest_first
    @products = @products.search(params[:search]) if params[:search].present?
    @products = @products.condition_id(params[:condition_id]) if params[:condition_id].present?
    return unless params[:category_id].present?

    @products = @products.category_id(params[:category_id])
  end

  def sell
    @product = set_product
    @seller = @product.user_id
  end

  def smail
    @product = set_product
    @seller = @product.user_id
    @current_user = current_user
    InterestMailer.with(seller_id: @seller, current_user: @current_user).notify.deliver_now
    redirect_to request.referrer, notice: 'Interest mail sent !!'
  end

  def show
    @user = @product.user
    return unless user_signed_in? && current_user != @product.user

    @full_cost = @product.price + (@delivery_cost.to_f * 100)
    @session_id = session.id
  end

  def new
    @product = Product.new
    @categories = Category.all
    @conditions = Condition.all
  end

  def edit
    @categories = Category.all
    @conditions = Condition.all
    @product = set_product
  end

  def create
    @product = current_user.products.create(product_params)
    @product.location = current_user.postcode

    if @product.save
      redirect_to @product, notice: 'Product was successfully created, and waiting for approval.'
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product = set_product
    @product.destroy if @product.present?

    redirect_to products_url, alert: 'Product was successfully destroyed.'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :location, :description, :category_id, :condition_id, :picture,
                                    :person)
  end

  def set_user_product
    @product = current_user.products.find_by_id(params[:id])

    redirect_to products_path if @product.nil?
  end

  def set_categories
    @categories = Category.all.order(:name)
  end
end

# rubocop:enable Style/Documentation, Metrics/AbcSize
