# frozen_string_literal: true

class AdminController < ApplicationController
  def pending_approvals
    @products = Product.where(is_approved: false).order('created_at DESC')
    @bproducts = Bproduct.where(is_approved: false).order('created_at DESC')
  end

  def confirmed_approvals
    @products = Product.where(is_approved: true).order('created_at DESC')
    @bproducts = Bproduct.where(is_approved: true).order('created_at DESC')
  end

  def seller
    @products = Product.all
    @users = User.all
  end

  def buyer
    @bproducts = Product.all
    @users = User.all
  end

  def create_categories
    @categories = Category.all
  end

  def edit
    @product = Product.find(params[:id])
    @bproduct = Bproduct.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)

    @bproduct = Bproduct.find(params[:id])
    @bproduct.update(bproduct_params)

    redirect_to admin_path, notice: 'Product is successfully updated.'
  end

  def approve_product
    @product = Product.find(params[:id])
    return unless @product.update_attribute(:is_approved, true)

    redirect_to @product, notice: 'Product approved.'
  end

  def approve_bproduct
    @bproduct = Bproduct.find(params[:id])
    return unless @bproduct.update_attribute(:is_approved, true)

    redirect_to @bproduct, notice: 'BProduct approved.'
  end

  def reject_product
    @product = Product.find(params[:id])
    return unless @product.update_attribute(:is_approved, false)

    @product.destroy
    redirect_to request.referrer, notice: 'Product rejected.'
  end

  def reject_bproduct
    @bproduct = Bproduct.find(params[:id])
    return unless @bproduct.update_attribute(:is_approved, false)

    @bproduct.destroy
    redirect_to request.referrer, notice: 'BProduct rejected.'
  end

  private

  def product_params
    params.require(:product).permit(:is_approved)
  end

  def bproduct_params
    params.require(:bproduct).permit(:is_approved)
  end
end
