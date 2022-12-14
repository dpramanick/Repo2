# frozen_string_literal: true

# rubocop:disable Style/Documentation

class AddIsApprovedToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :is_approved, :boolean, default: false
  end
end

# rubocop:enable Style/Documentation
