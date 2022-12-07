# frozen_string_literal: true

class CreateBreviews < ActiveRecord::Migration[7.0]
  def change
    create_table :breviews do |t|
      t.integer :rating
      t.text :comment
      t.integer :user_id
      t.integer :bproduct_id

      t.timestamps
    end
  end
end
