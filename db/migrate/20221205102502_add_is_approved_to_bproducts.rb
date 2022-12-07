# frozen_string_literal: true

class AddIsApprovedToBproducts < ActiveRecord::Migration[7.0]
  def change
    add_column :bproducts, :is_approved, :boolean, default: false
  end
end
