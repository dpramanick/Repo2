# frozen_string_literal: true

class BproductsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_bproduct, only: [:show]
  before_action :set_user_bproduct, only: %i[edit update destroy]
  before_action :set_categories

  def index
    @bproducts = Bproduct.order('created_at desc').where('purchased = false').page params[:page]

    @bproducts = @bproducts.search(params[:search]) if params[:search].present?

    @bproducts = @bproducts.condition_id(params[:condition_id]) if params[:condition_id].present?
    return unless params[:category_id].present?

    @bproducts = @bproducts.category_id(params[:category_id])
  end

  def sell
    @bproduct = Bproduct.find(params[:id])
    @seller = @bproduct.user_id
  end

  def smail
    @bproduct = Bproduct.find(params[:id])
    @seller = @bproduct.user_id
    @current_user = current_user
    InterestMailer.with(seller_id: @seller, current_user: @current_user).notify.deliver_now
    redirect_to request.referrer, notice: 'Interest mail sent !!'
  end

  def show
    @user = @bproduct.user
    return unless user_signed_in? && current_user != @bproduct.user

    response = auspost_api_get
    @full_cost = @bproduct.price + (@delivery_cost.to_f * 100)
    @session_id = session.id
  end

  def new
    @bproduct = Bproduct.new
    @categories = Category.all
    @conditions = Condition.all
  end

  def edit
    @categories = Category.all
    @conditions = Condition.all
    @bproduct = Bproduct.find(params[:id])
  end

  def create
    @bproduct = current_user.bproducts.create(bproduct_params)
    @bproduct.location = current_user.postcode
    @bproduct.purchased = false

    if @bproduct.save
      redirect_to @bproduct, notice: 'BProduct was successfully created, and waiting for approval.'
    else
      render :new
    end
  end

  def update
    if @bproduct.update(bproduct_params)
      redirect_to @bproduct, notice: 'BProduct was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @bproduct = set_bproduct
    @bproduct.destroy if @bproduct.present?

    redirect_to bproducts_url, notice: 'BProduct was successfully destroyed.'
  end

  private

  def set_bproduct
    @bproduct = Bproduct.find(params[:id])
  end

  def bproduct_params
    params.require(:bproduct).permit(:name, :price, :location, :description, :category_id, :condition_id, :picture)
  end

  def set_user_bproduct
    @bproduct = current_user.bproducts.find_by_id(params[:id])

    redirect_to bproducts_path if @bproduct.nil?
  end

  def set_categories
    @categories = Category.all.order(:name)
  end

  def auspost_api_get
    seller_postcode = @bproduct.location
    buyer_postcode = current_user.postcode

    length = rand(5..25)
    width = rand(5..25)
    height = rand(5..25)
    weight = rand(1..10)
  end
end
