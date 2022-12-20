# frozen_string_literal: true

# rubocop:disable Style/Documentation

class AddConditionIdToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :condition, foreign_key: true
  end
end

# rubocop:enable Style/Documentation
