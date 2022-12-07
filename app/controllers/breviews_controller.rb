# frozen_string_literal: true

class BreviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_bproduct
  before_action :find_breview, only: %i[edit update destroy]
  #before_action :has_breviewed

  def new
    @breview = Breview.new
  end

  def create
    @breview = Breview.new(breview_params)
    @breview.bproduct_id = @bproduct.id
    @breview.user_id = current_user.id

    if @breview.save
      redirect_to bproduct_path(@bproduct)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @breview.update(breview_params)
      redirect_to bproduct_path(@bproduct)
    else
      render 'edit'
    end
  end

  def destroy
    @review.destroy
    redirect_to_bproduct_path(@bproduct)
  end

  private

  def breview_params
    params.require(:breview).permit(:rating, :comment)
  end

  def find_bproduct
    @bproduct = Bproduct.find(params[:bproduct_id])
  end

  def find_breview
    @breview = Breview.find(params[:id])
  end

  #def has_breviewed
  #  if current_user.breview.exists?(bproduct: @bproduct)
  #    redirect_to bproduct_path(@bproduct), notice: "You've already written a review for this Bproduct!" 
  #  end
  #end
end
