# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product
  before_action :find_review, only: %i[edit update destroy]
  before_action :has_reviewed, only: [:new]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.product_id = @product.id
    @review.user_id = current_user.id

    if @review.save
      redirect_to product_path(@product)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @review.update(review_params)
      redirect_to product_path(@product)
    else
      render 'edit'
    end
  end

  def destroy
    @review.destroy
    redirect_to_product_path(@product)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def find_product
    @product = Product.find(params[:product_id])
  end

  def find_review
    @review = Review.find(params[:id])
  end

  def has_reviewed
    redirect_to product_path(@product), notice: "You've already written a review for this product!"
  end
end
