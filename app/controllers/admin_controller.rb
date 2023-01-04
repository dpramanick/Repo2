# frozen_string_literal: true

# rubocop:disable Style/Documentation

class AdminController < ApplicationController
  def pending_approvals
    @products = Product.is_approved(false)
  end

  def confirmed_approvals
    @products = Product.is_approved(true)
  end

  def seller
    @products = Product.all
    @users = User.all
  end

  def buyer
    @products = Product.all
    @users = User.all
  end

  def create_categories
    @categories = Category.all
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)

    redirect_to admin_path, notice: 'Product is successfully updated.'
  end

  def approve_product
    @product = Product.find(params[:id])
    return unless @product.update_attribute(:is_approved, true)

    redirect_to request.referrer, notice: 'Product approved.'
  end

  def reject_product
    @product = Product.find(params[:id])
    return unless @product.update_attribute(:is_approved, false)

    @product.destroy
    redirect_to request.referrer, notice: 'Product rejected.'
  end

  private

  def product_params
    params.require(:product).permit(:is_approved)
  end
end

# rubocop:enable Style/Documentation
