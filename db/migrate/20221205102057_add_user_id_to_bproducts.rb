# frozen_string_literal: true

class AddUserIdToBproducts < ActiveRecord::Migration[7.0]
  def change
    add_column :bproducts, :user_id, :integer
  end
end
