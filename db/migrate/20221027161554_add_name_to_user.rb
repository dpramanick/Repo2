# frozen_string_literal: true

# rubocop:disable Style/Documentation

class AddNameToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
  end
end

# rubocop:enable Style/Documentation
