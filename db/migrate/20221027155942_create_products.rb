# frozen_string_literal: true

# rubocop:disable Style/Documentation

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.text :location
      t.text :description

      t.timestamps
    end
  end
end

# rubocop:enable Style/Documentation
