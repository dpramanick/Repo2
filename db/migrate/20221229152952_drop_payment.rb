# frozen_string_literal: true

# rubocop:disable Style/Documentation

class DropPayment < ActiveRecord::Migration[7.0]
  def change
    drop_table :payments
  end
end

# rubocop:enable Style/Documentation
