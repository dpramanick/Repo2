# frozen_string_literal: true

# rubocop:disable Style/Documentation

class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]

  def success
    @purchase = Payment.where(user_id: current_user.id).last
    @product = Product.find(@purchase.product_id)
  end
end

# rubocop:enable Style/Documentation
