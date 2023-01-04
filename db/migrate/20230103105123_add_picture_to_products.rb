# frozen_string_literal: true

# rubocop:disable Style/Documentation

class AddPictureToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :picture, :binary
  end
end

# rubocop:enable Style/Documentation
