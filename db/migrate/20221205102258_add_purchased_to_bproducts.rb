class AddPurchasedToBproducts < ActiveRecord::Migration[7.0]
  def change
    add_column :bproducts, :purchased, :boolean
  end
end
