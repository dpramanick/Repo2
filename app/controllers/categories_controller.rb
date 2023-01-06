# frozen_string_literal: true

# rubocop:disable Style/Documentation

class CategoriesController < ApplicationController
  before_action :set_category

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      flash.now[:errors] = @category.errors.full_messages
      render :new
    end
  end

  def show
    @category = set_category
  end
  
  def edit
    @category = set_category
  end

  def update
    @category = set_category
    if @category.update(category_params)
      redirect_to categories_path
    else
      flash.now[:errors] = @category.errors.full_messages
      render :new
    end
  end

  def destroy
    @category = set_category
    @category.destroy
    
    redirect_to request.referrer, notice: 'Category deleted.'
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end

# rubocop:enable Style/Documentation
