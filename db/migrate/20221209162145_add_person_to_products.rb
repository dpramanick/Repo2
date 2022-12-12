# frozen_string_literal: true

class AddPersonToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :person, :string
  end
end
