class AddCategoryIdToBproducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :bproducts, :category, null: false, foreign_key: true
  end
end
