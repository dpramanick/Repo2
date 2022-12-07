# frozen_string_literal: true

class CreateBproducts < ActiveRecord::Migration[7.0]
  def change
    create_table :bproducts do |t|
      t.string :name
      t.integer :price
      t.text :location
      t.text :description

      t.timestamps
    end
  end
end
